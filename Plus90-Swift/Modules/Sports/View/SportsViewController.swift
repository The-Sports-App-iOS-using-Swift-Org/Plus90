//
//  SportsViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 06/05/2026.
//

import UIKit
class SportsViewController: UIViewController {
    @IBOutlet weak var headerSportsView: UIView!
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerSportsViewDecoration()
        setupCollectionView()
    }
    func headerSportsViewDecoration() {
        headerSportsView.layer.cornerRadius = 40
        headerSportsView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    func setupCollectionView() {
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        sportsCollectionView.register(nib, forCellWithReuseIdentifier: "SportsCell")
    }
}

extension SportsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsets: CGFloat = 30
        let interItemSpacing: CGFloat = 15
        let availableWidth = collectionView.frame.width - sectionInsets - interItemSpacing
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: itemWidth + 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
}
