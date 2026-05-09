//
//  File.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func renderTeamData(_ team: Team)
    func showError(_ message: String)
}

class TeamPresenter {
    
    private weak var view: TeamDetailsViewProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(view: TeamDetailsViewProtocol, networkService: NetworkServiceProtocol = NetworkService()) {
        self.view = view
        self.networkService = networkService
    }
    
    func getTeamDetails(id: Int) {
        view?.showLoading()
        
        networkService.fetchTeamDetails(teamId: id) { [weak self] team in
            guard let self = self else { return }
            self.view?.hideLoading()
            
            if let teamInfo = team {
                self.view?.renderTeamData(teamInfo)
            } else {
                self.view?.showError("Failed to fetch team data.")
            }
        }
    }
    
    // Logic for counting items (Presenter handles the "Numbers")
    func getPlayersCount(team: Team?) -> Int {
        return team?.players?.count ?? 0
    }
    
    func getCoachesCount(team: Team?) -> Int {
        return team?.coaches?.count ?? 0
    }
}
