//
//  LeaguesViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import UIKit
import Network

class LeaguesViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var leaguesTableView: UITableView!
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemGreen
        indicator.hidesWhenStopped = true
        return indicator
    }()
    var presenter: LeaguesPresenterProtocol?
    var selectedSportName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
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

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        applyTheme()
    }

    private func applyTheme() {
        view.backgroundColor = AppColors.primaryBackground
        headerView.backgroundColor = AppColors.headerBackground
        activityIndicator.color = AppColors.accent
        leaguesTableView.backgroundColor = AppColors.primaryBackground
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
    }

    func setupHeaderShape() {
        headerView.layer.cornerRadius = 40
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }

    private func setupTableView() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesTableView.separatorStyle = .none
        leaguesTableView.backgroundColor = .clear
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "LeaguesCell")
    }

    private func showNetworkError() {
        let alert = UIAlertController(
            title: "Network Connection",
            message: "You are offline. Please check your internet connection to view league details.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension LeaguesViewController: LeaguesViewProtocol {
    func startAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.leaguesTableView.alpha = 0
        }
    }
    func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.3) {
                self.leaguesTableView.alpha = 1
            }
        }
    }
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

        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkCheck")

        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                monitor.cancel()
                if path.status == .satisfied {
                    if let detailsVC = self?.storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsVC") as? LeaguesDetailsViewController {
                        detailsVC.leagueId = selectedLeague.leagueKey
                        detailsVC.leagueName = selectedLeague.leagueName
                        detailsVC.leagueRegion = selectedLeague.countryName
                        detailsVC.leagueImageUrl = selectedLeague.leagueLogo
                        detailsVC.hidesBottomBarWhenPushed = true
                        self?.navigationController?.pushViewController(detailsVC, animated: true)
                    }
                } else {
                    self?.showNetworkError()
                }
            }
        }
        monitor.start(queue: queue)
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
