//
//  LeaguesDetailsViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 08/05/2026.
//

import UIKit

class LeaguesDetailsViewController: UIViewController {

    @IBOutlet weak var leaguesCompositionalLeaguesCollectionView: UICollectionView!
    
    var leagueId: Int?
    private var networkService: NetworkServiceProtocol = NetworkService()
    
    private var latestEvents: [MatchEvent] = []
    private var teams: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchDetailsData()
    }

    private func setupCollectionView() {
        leaguesCompositionalLeaguesCollectionView.delegate = self
        leaguesCompositionalLeaguesCollectionView.dataSource = self
        
        let latestEventNib = UINib(nibName: "LatestEventCollectionViewCell", bundle: nil)
        leaguesCompositionalLeaguesCollectionView.register(latestEventNib, forCellWithReuseIdentifier: "LatestEventCell")
        
        let teamNib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        leaguesCompositionalLeaguesCollectionView.register(teamNib, forCellWithReuseIdentifier: "TeamsCell")
        
        leaguesCompositionalLeaguesCollectionView.register(SectionHeaderView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "SectionHeaderView")
        
        leaguesCompositionalLeaguesCollectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
    }
    
    private func fetchDetailsData() {
        guard let id = leagueId else { return }
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkService.fetchLatestEvents(leagueId: id) { [weak self] response in
            self?.latestEvents = response?.result ?? []
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkService.fetchTeams(leagueId: id) { [weak self] response in
            self?.teams = response?.result ?? []
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.leaguesCompositionalLeaguesCollectionView.reloadData()
        }
    }
}

extension LeaguesDetailsViewController {
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 1:
                return self.createVerticalLatestEventsSection()
            case 2:
                return self.createHorizontalTeamsSection()
            default:
                // Placeholder for your 1st section later
                return self.createEmptyPlaceholderSection()
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    private func createVerticalLatestEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
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

extension LeaguesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch section {
            case 1: return latestEvents.count
            case 2: return teams.count
            default: return 0 // Section 0 is empty for now
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
}
