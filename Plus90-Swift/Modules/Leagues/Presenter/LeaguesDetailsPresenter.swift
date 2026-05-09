//
//  LeaguesDetailsPresenter.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import Foundation


protocol LeaguesDetailsPresenterProtocol{
    func loadData()
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
}
