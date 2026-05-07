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
    var presenter: SportsPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SportsPresenter()
        presenter?.attachView(self)
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
extension SportsViewController: SportsViewProtocol {
    func startAnimating() {}
    func stopAnimating() {}
    func reloadCollection() {
        sportsCollectionView.reloadData()
    }
}
extension SportsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getSportsCount() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectSport(at: indexPath.row)
        let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesVC") as! LeaguesViewController
        navigationController?.pushViewController(leaguesVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCollectionViewCell
        if let sport = presenter?.getSport(at: indexPath.row) {
            cell.configure(name: sport.name, image: sport.image)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 45
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: itemWidth + 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
}
