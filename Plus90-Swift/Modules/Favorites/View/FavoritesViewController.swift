//
//  FavoritesViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 06/05/2026.
//

import UIKit
// Modules/Favoraites/View/FavoritesViewController
protocol FavoritesViewProtocol: AnyObject {
    func reloadData()
    func showDeleteConfirmation(at index: Int, leagueName: String)
    func toggleEmptyState(show: Bool)
    func navigateToDetails(with league: FavoriteLeague)
    func showNetworkError()
}


class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cardContainerView: UIView!

    private var headerMaskLayer = CAShapeLayer()
    private lazy var presenter: FavoritesPresenterProtocol = FavoritesPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderShape()
        setupCardShadow()
        setupTableView()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
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
    func showDeleteConfirmation(at index: Int, leagueName: String) {
        let alert = UIAlertController(
            title: "Remove Favorite",
            message: "Are you sure you want to remove \(leagueName) from your favorites?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Remove", style: .destructive) { _ in
            self.presenter.confirmRemoval(at: index)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    func toggleEmptyState(show: Bool) {
        if show {
            let emptyView = UIView(frame: tableView.bounds)
            
            let icon = UIImageView(image: UIImage(systemName: "heart.slash"))
            icon.tintColor = .systemGray4
            icon.contentMode = .scaleAspectFit
            
            let label = UILabel()
            label.text = "No Favorites Yet"
            label.font = .systemFont(ofSize: 18, weight: .medium)
            label.textColor = .secondaryLabel
            
            let stack = UIStackView(arrangedSubviews: [icon, label])
            stack.axis = .vertical
            stack.spacing = 10
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            emptyView.addSubview(stack)
            NSLayoutConstraint.activate([
                stack.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                stack.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
                icon.heightAnchor.constraint(equalToConstant: 60),
                icon.widthAnchor.constraint(equalToConstant: 60)
            ])
            
            tableView.backgroundView = emptyView
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
    }
    
    func navigateToDetails(with league: FavoriteLeague) {
        guard let nav = self.navigationController else {
            return
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "LeaguesDetailsVC") as? LeaguesDetailsViewController {
            detailsVC.leagueId = Int(league.id)
            detailsVC.leagueName = league.name
            detailsVC.leagueRegion = league.region
            detailsVC.leagueImageUrl = league.imageName
            detailsVC.hidesBottomBarWhenPushed = true
            nav.pushViewController(detailsVC, animated: true)
        }
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Network Connection",
            message: "You are offline. Please check your internet connection to view league details.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getFavoritesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteLeagueCell", for: indexPath) as? FavoriteLeagueCell else {
            return UITableViewCell()
        }
        let item = presenter.getFavoriteItem(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            presenter.didSelectFavorite(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                presenter.didRequestRemoval(at: indexPath.row)
            }
        }
        
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
            return "Remove"
    }
}
