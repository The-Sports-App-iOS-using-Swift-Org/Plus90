//
//  File.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation

protocol LeaguesViewProtocol: AnyObject {
    func startAnimating()
    func stopAnimating()
    func reloadTable()
    func showError(message: String)
}

protocol LeaguesPresenterProtocol {
    func fetchLeagues(for sportName: String)
    func getLeaguesCount() -> Int
    func getLeague(at index: Int) -> League
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    weak var view: LeaguesViewProtocol?
    private let networkService: NetworkServiceProtocol
    private var leagues: [League] = []

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchLeagues(for sportName: String) {
        view?.startAnimating()
        
        let completion: (LeagueResponse?) -> Void = { [weak self] response in
            guard let self = self else { return }
            self.view?.stopAnimating()
            if let allLeagues = response?.result {
                if sportName.lowercased() == "football" {
                    self.leagues = allLeagues.filter { league in
                        return league.leagueLogo != nil && !league.leagueLogo!.isEmpty
                    }
                } else {
                    self.leagues = allLeagues
                }
                self.view?.reloadTable()
            } else {
                self.view?.showError(message: "No data available.")
            }
        }
        switch sportName.lowercased() {
        case "football": networkService.fetchFootBallLeagues(completion: completion)
        case "tennis": networkService.fetchTennisLeagues(completion: completion)
        case "basketball": networkService.fetchBasketBallLeagues(completion: completion)
        case "cricket": networkService.fetchCricketLeagues(completion: completion)
        default: break
        }
    }

    func getLeaguesCount() -> Int { leagues.count }
    func getLeague(at index: Int) -> League { leagues[index] }
}
