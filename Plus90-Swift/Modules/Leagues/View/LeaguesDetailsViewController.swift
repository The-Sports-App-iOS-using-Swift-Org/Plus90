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
        
        leaguesCompositionalLeaguesCollectionView.register(SectionHeaderView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "SectionHeaderView")
        
        leaguesCompositionalLeaguesCollectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
    }
    
    private func fetchDetailsData() {
        guard let id = leagueId else {
            print("Error: No league ID provided")
            return
        }
        
        networkService.fetchLatestEvents(leagueId: id) { [weak self] response in
            guard let self = self else { return }
            
            if let matches = response?.result {
                self.latestEvents = matches
                
                DispatchQueue.main.async {
                    self.leaguesCompositionalLeaguesCollectionView.reloadData()
                }
            } else {
                print("No matches found for league ID: \(id)")
            }
        }
    }
}

extension LeaguesDetailsViewController {
    
   
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createVerticalLatestEventsSection()
        }
    }

    private func createVerticalLatestEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
   
}

extension LeaguesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventCell", for: indexPath) as! LatestEventCollectionViewCell
        
        let match = latestEvents[indexPath.item]
        cell.configure(with: match)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
            header.titleLabel.text = "Latest Events"
            return header
        }
        return UICollectionReusableView()
    }
}
