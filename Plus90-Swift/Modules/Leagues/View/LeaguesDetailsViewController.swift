//  LeaguesDetailsViewController.swift
//  Plus90-Swift
//  Created by Nemo on 08/05/2026.


import UIKit

protocol LeaguesDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func refreshUI(events: [MatchEvent], teams: [Team])
    func updateFavoriteButton(isFavorite: Bool)
}

class LeaguesDetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var leaguesCompositionalLeaguesCollectionView: UICollectionView!
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    var leagueId: Int?
    var leagueName: String?
    var leagueRegion: String?
    var leagueImageUrl: String?
    
    private var presenter: LeaguesDetailsPresenterProtocol!
    private var latestEvents: [MatchEvent] = []
    private var teams: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupHeartImageGesture()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        if let id = leagueId {
            presenter = LeaguesDetailsPresenter(view: self, leagueId: id)
            presenter.loadData()
            
            if let name = leagueName {
                presenter.checkFavoriteStatus(name: name)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupHeartImageGesture() {
        heartImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        heartImage.addGestureRecognizer(tapGesture)
    }
    
    private func setupCollectionView() {
        leaguesCompositionalLeaguesCollectionView.delegate = self
        leaguesCompositionalLeaguesCollectionView.dataSource = self
        
        leaguesCompositionalLeaguesCollectionView.register(UINib(nibName: "LatestEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventCell")
        leaguesCompositionalLeaguesCollectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamsCell")
        
        leaguesCompositionalLeaguesCollectionView.register(SectionHeaderView.self,
                                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                         withReuseIdentifier: "SectionHeaderView")
        
        leaguesCompositionalLeaguesCollectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
    }
    
    @objc private func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoriteTapped() {
    
        guard let name = leagueName else {
            print("Error: leagueName is NIL. Check the previous screen's data passing!")
            return
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.heartImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.heartImage.transform = .identity
            }
        }
        
        presenter.toggleFavorite(name: name,
                                region: leagueRegion ?? "Unknown",
                                image: leagueImageUrl ?? "")
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }
}

extension LeaguesDetailsViewController: LeaguesDetailsViewProtocol {
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.leaguesCompositionalLeaguesCollectionView.alpha = 0
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.3) {
                self.leaguesCompositionalLeaguesCollectionView.alpha = 1.0
            }
        }
    }
    
    func refreshUI(events: [MatchEvent], teams: [Team]) {
        self.latestEvents = events
        self.teams = teams
        DispatchQueue.main.async {
            self.leaguesCompositionalLeaguesCollectionView.reloadData()
        }
    }
    
    func updateFavoriteButton(isFavorite: Bool) {
        DispatchQueue.main.async {
            print("Protocol called: updateFavoriteButton with status: \(isFavorite)")
            let imageName = isFavorite ? "heart.fill" : "heart"
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
            
            self.heartImage.image = UIImage(systemName: imageName, withConfiguration: config)
            self.heartImage.tintColor = isFavorite ? .systemRed : .white
        }
    }
}

extension LeaguesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1: return latestEvents.count
        case 2: return teams.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventCell", for: indexPath) as! LatestEventCollectionViewCell
            cell.configure(with: latestEvents[indexPath.item])
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCollectionViewCell
            cell.configure(with: teams[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
            
            switch indexPath.section {
            case 1: header.titleLabel.text = "Latest Events"
            case 2: header.titleLabel.text = "Teams"
            default: header.titleLabel.text = ""
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let selectedTeam = teams[indexPath.item]
            if let teamDetailsVC = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsVC") as? TeamDetailsViewController {
                teamDetailsVC.teamId = selectedTeam.teamKey
                self.navigationController?.pushViewController(teamDetailsVC, animated: true)
            }
        }
    }
}

extension LeaguesDetailsViewController {
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 1: return self.createVerticalLatestEventsSection()
            case 2: return self.createHorizontalTeamsSection()
            default: return self.createEmptyPlaceholderSection()
            }
        }
    }
    
    private func createEmptyPlaceholderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private func createHorizontalTeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 20, trailing: 16)
        section.boundarySupplementaryItems = [createHeaderSupplementaryItem()]
        return section
    }

    private func createVerticalLatestEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderSupplementaryItem()]
        return section
    }
    
    private func createHeaderSupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
