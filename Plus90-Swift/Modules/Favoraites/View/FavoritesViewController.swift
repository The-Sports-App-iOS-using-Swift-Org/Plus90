//
//  FavoritesViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 06/05/2026.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func reloadData()
}


class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cardContainerView: UIView!
    private var headerMaskLayer = CAShapeLayer()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderShape()
        setupCardShadow()
        setupTableView()
     
    }

    private func setupHeaderShape() {
        headerView.backgroundColor = .systemGreen
        
        let path = UIBezierPath(roundedRect: headerView.bounds,
                                byRoundingCorners: [.bottomLeft],
                                cornerRadii: CGSize(width: 80, height: 60))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        headerView.layer.mask = mask
    }

    private func setupCardShadow() {
        cardContainerView.layer.cornerRadius = 24
        cardContainerView.layer.shadowColor = UIColor.black.cgColor
        cardContainerView.layer.shadowOpacity = 0.08
        cardContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardContainerView.layer.shadowRadius = 15
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteLeagueCell.self, forCellReuseIdentifier: "FavoriteLeagueCell")
    }



    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let path = UIBezierPath(roundedRect: headerView.bounds,
                                byRoundingCorners: [.bottomLeft],
                                cornerRadii: CGSize(width: 80, height: 60))
        
        headerMaskLayer.path = path.cgPath
        headerView.layer.mask = headerMaskLayer
    }

}

extension FavoritesViewController: FavoritesViewProtocol {
    func reloadData() {
        tableView.reloadData()
        self.view.setNeedsLayout()
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteLeagueCell", for: indexPath) as? FavoriteLeagueCell else {
            return UITableViewCell()
        }
      
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
}
