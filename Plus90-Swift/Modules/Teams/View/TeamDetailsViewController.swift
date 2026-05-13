//
//  TeamDetailsViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 7/05/2026.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamDetailsCollectionView: UICollectionView!

    var teamId: Int?
    private var teamData: Team?
    private var presenter: TeamsPresnterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        presenter = TeamPresenter(view: self)
        presenter.fetchDetails(teamId: teamId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance = nil
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyTheme()
        applyNavBar()
    }

    private func applyTheme() {
        view.backgroundColor = AppColors.primaryBackground
        teamDetailsCollectionView.backgroundColor = AppColors.primaryBackground
    }

    private func setupUI() {
        applyTheme()
        title = "TEAM SQUAD"

        navigationController?.navigationBar.tintColor = AppColors.accent

        navigationItem.backButtonDisplayMode = .minimal

        applyNavBar()
    }

    private func applyNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.headerBackground
        appearance.shadowColor = .clear

        let titleAttr: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppColors.headerText,           // always white on green
            .font: UIFont(name: "AvenirNext-Heavy", size: 16)
                   ?? UIFont.systemFont(ofSize: 16, weight: .heavy),
            .kern: CGFloat(2.0)
        ]
        appearance.titleTextAttributes = titleAttr

        navigationController?.navigationBar.standardAppearance  = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance    = appearance
        navigationController?.navigationBar.tintColor            = AppColors.headerText
    }

    // MARK: - Collection View
    private func setupCollectionView() {
        teamDetailsCollectionView.delegate   = self
        teamDetailsCollectionView.dataSource = self
        teamDetailsCollectionView.backgroundColor = AppColors.primaryBackground
        teamDetailsCollectionView.showsVerticalScrollIndicator = false
        teamDetailsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)

        teamDetailsCollectionView.register(
            UINib(nibName: "TeamHeaderCell", bundle: nil),
            forCellWithReuseIdentifier: "HeaderCell")
        teamDetailsCollectionView.register(
            UINib(nibName: "StaffCell", bundle: nil),
            forCellWithReuseIdentifier: "StaffCell")
        teamDetailsCollectionView.register(
            UINib(nibName: "PlayerCell", bundle: nil),
            forCellWithReuseIdentifier: "PlayerCell")
        teamDetailsCollectionView.register(
            TeamSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeader")

        teamDetailsCollectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
}

extension TeamDetailsViewController: TeamDetailsViewProtocol {

    func startLoading() { }

    func stopLoading() { }

    func displayTeamData(_ team: Team) {
        self.teamData = team
        DispatchQueue.main.async {
            self.teamDetailsCollectionView.reloadData()
        }
    }

    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension TeamDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int { 3 }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return teamData?.coaches?.count ?? 0
        case 2: return teamData?.players?.count ?? 0
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "HeaderCell", for: indexPath) as! TeamHeaderCell
            if let data = teamData {
                cell.configure(name: data.teamName, logoUrl: data.teamLogo)
            }
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "StaffCell", for: indexPath) as! StaffCell
            if let coach = teamData?.coaches?[indexPath.item] {
                cell.configure(with: coach)
            }
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
            if let player = teamData?.players?[indexPath.item] {
                cell.configure(with: player)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeader",
            for: indexPath) as! TeamSectionHeaderView
        switch indexPath.section {
        case 1: header.configure(title: "Manager & Staff")
        case 2: header.configure(title: "Active Roster")
        default: header.configure(title: "")
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard indexPath.section > 0 else { return }
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(
            withDuration: 0.35,
            delay: 0.04 * Double(indexPath.item),
            options: .curveEaseOut
        ) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}

// MARK: - Compositional Layout
extension TeamDetailsViewController {

    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return self.createHeaderSection()
            case 1: return self.createStaffSection()
            default: return self.createPlayerSection()
            }
        }
    }

    private func createHeaderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(240))
        let item  = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        return section
    }

    private func createStaffSection() -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                               heightDimension: .absolute(175))
        let group     = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section   = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16)
        section.boundarySupplementaryItems = [createSectionHeader(height: 50)]
        return section
    }

    private func createPlayerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(76))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
        let group   = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSectionHeader(height: 50)]
        return section
    }

    private func createSectionHeader(height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .absolute(height))
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
    }
}
