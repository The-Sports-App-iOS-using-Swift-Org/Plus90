//
//  LeaguesDetailsPresenter.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import Foundation

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
        
        var upcomingEvents: [MatchEvent] = []
        var latestEvents: [MatchEvent] = []
        var teams: [Team] = []
        
        group.enter()
        networkService.fetchUpcomingEvents(leagueId: leagueId) { response in
            upcomingEvents = response?.result ?? []
            group.leave()
        }
        
        group.enter()
        networkService.fetchLatestEvents(leagueId: leagueId) { response in
            latestEvents = response?.result ?? []
            group.leave()
        }
        
        group.enter()
        networkService.fetchTeams(leagueId: leagueId) { response in
            teams = response?.result ?? []
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.view?.hideLoading()
            // Passing all three arrays to the View
            self.view?.refreshUI(upcoming: upcomingEvents, latest: latestEvents, teams: teams)
        }
    }
    
    func toggleFavorite(name: String, region: String, image: String) {
        if CoreDataManager.shared.isLeagueFavorite(name: name) {
            CoreDataManager.shared.deleteLeague(name: name)
            view?.updateFavoriteButton(isFavorite: false)
        } else {
            CoreDataManager.shared.saveLeague(
                id: Int64(self.leagueId),
                name: name,
                region: region,
                image: image
            )
            view?.updateFavoriteButton(isFavorite: true)
        }
    }

    func checkFavoriteStatus(name: String) {
        let isFav = CoreDataManager.shared.isLeagueFavorite(name: name)
        view?.updateFavoriteButton(isFavorite: isFav)
    }
}
