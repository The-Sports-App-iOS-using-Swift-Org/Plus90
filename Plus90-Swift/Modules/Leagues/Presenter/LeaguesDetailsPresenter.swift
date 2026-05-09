//
//  LeaguesDetailsPresenter.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import Foundation


protocol LeaguesDetailsPresenterProtocol{
    func loadData()
    func toggleFavorite(name: String, region: String, image: String) 
    func checkFavoriteStatus(name: String)
}
class LeaguesDetailsPresenter : LeaguesDetailsPresenterProtocol {
    private weak var view: LeaguesDetailsViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let leagueId: Int
    
    init(view: LeaguesDetailsViewProtocol, leagueId: Int, networkService: NetworkServiceProtocol = NetworkService()) {
        self.view = view
        self.leagueId = leagueId
        self.networkService = networkService
    }
    
    
    func loadData() {
        view?.showLoading()
        let group = DispatchGroup()
        var events: [MatchEvent] = []
        var teams: [Team] = []
        
        group.enter()
        networkService.fetchLatestEvents(leagueId: leagueId) { response in
            events = response?.result ?? []
            group.leave()
        }
        
        group.enter()
        networkService.fetchTeams(leagueId: leagueId) { response in
            teams = response?.result ?? []
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            self?.view?.refreshUI(events: events, teams: teams)
        }
    }
    
    func toggleFavorite(name: String, region: String, image: String) {
        if CoreDataManager.shared.isLeagueFavorite(name: name) {
            CoreDataManager.shared.deleteLeague(name: name)
            // THIS LINE IS REQUIRED:
            view?.updateFavoriteButton(isFavorite: false)
        } else {
            CoreDataManager.shared.saveLeague(name: name, region: region, image: image)
            // THIS LINE IS REQUIRED:
            view?.updateFavoriteButton(isFavorite: true)
        }
    }

    
    func checkFavoriteStatus(name: String) {
            let isFav = CoreDataManager.shared.isLeagueFavorite(name: name)
            view?.updateFavoriteButton(isFavorite: isFav)
    }
    
}
