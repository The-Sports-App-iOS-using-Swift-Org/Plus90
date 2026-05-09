//
//  LeaguesDetailsViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 08/05/2026.
//

import UIKit

class LeaguesDetailsViewController: UIViewController {

    @IBOutlet weak var LeaguesDetailsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    private func setupCollectionView() {
        LeaguesDetailsCollectionView.clipsToBounds = false
        let nib = UINib(nibName: "UpcomingCollectionViewCell", bundle: nil)
        LeaguesDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "UpcomingCollectionViewCell")
        LeaguesDetailsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        LeaguesDetailsCollectionView.collectionViewLayout = createCompositionalLayout()
        LeaguesDetailsCollectionView.dataSource = self
        LeaguesDetailsCollectionView.delegate = self
    }
}
extension LeaguesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 5 : 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as! UpcomingCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .lightGray
            return cell
        }
    }
}
extension LeaguesDetailsViewController {
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 20,leading: 16,bottom: 20,trailing: 16)
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
    }
}
