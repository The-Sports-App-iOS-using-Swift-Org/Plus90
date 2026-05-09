//
//  LeaguesViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet weak var leaguesTableView: UITableView!
    
    var presenter: LeaguesPresenterProtocol?
    var selectedSportName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        let leaguesPresenter = LeaguesPresenter()
        leaguesPresenter.view = self
        presenter = leaguesPresenter
        
        if let sport = selectedSportName {
            presenter?.fetchLeagues(for: sport)
        }
    }

    private func setupTableView() {
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
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
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
