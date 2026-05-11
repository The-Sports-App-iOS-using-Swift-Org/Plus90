//
//  LeaguesViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var leaguesTableView: UITableView!
    
    private var headerMaskLayer = CAShapeLayer()

    var presenter: LeaguesPresenterProtocol?
    var selectedSportName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderShape()
        setupTableView()
        setupBackButton()
        
        let leaguesPresenter = LeaguesPresenter()
        leaguesPresenter.view = self
        presenter = leaguesPresenter
        
        if let sport = selectedSportName {
            presenter?.fetchLeagues(for: sport)
        }
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        headerView.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            backButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func setupHeaderShape() {
        headerView.layer.cornerRadius = 40
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    private func setupTableView() {
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesTableView.separatorStyle = .none
        leaguesTableView.backgroundColor = .clear 
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "LeaguesCell")
    }
}

extension LeaguesViewController: LeaguesViewProtocol {
    func startAnimating() {}
    func stopAnimating() {}
    func reloadTable() {
        DispatchQueue.main.async { self.leaguesTableView.reloadData() }
    }
    func showError(message: String) { print(message) }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getLeaguesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as! LeaguesTableViewCell
        if let league = presenter?.getLeague(at: indexPath.row) {
            let placeholder = selectedSportName?.lowercased() ?? "placeholder"
            cell.configure(with: league, placeholderName: placeholder)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedLeague = presenter?.getLeague(at: indexPath.row) else { return }
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsVC") as? LeaguesDetailsViewController {
            detailsVC.leagueId = selectedLeague.leagueKey
            detailsVC.leagueName = selectedLeague.leagueName
            detailsVC.leagueRegion = selectedLeague.countryName
            detailsVC.leagueImageUrl = selectedLeague.leagueLogo
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.3, delay: 0.05 * Double(indexPath.row), options: .curveEaseOut) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { self?.image = image }
            }
        }.resume()
    }
}

extension LeaguesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }
}
