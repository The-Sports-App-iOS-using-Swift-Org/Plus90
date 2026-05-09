//
//  File.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func displayTeamData(_ team: Team)
    func displayError(message: String)
}

class TeamPresenter {
    private weak var view: TeamDetailsViewProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(view: TeamDetailsViewProtocol, networkService: NetworkServiceProtocol = NetworkService()) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchDetails(teamId: Int?) {
        guard let id = teamId else {
            view?.displayError(message: "Invalid Team ID")
            return
        }
        
        view?.startLoading()
        networkService.fetchTeamDetails(teamId: id) { [weak self] team in
            guard let self = self else { return }
            self.view?.stopLoading()
            
            if let teamInfo = team {
                self.view?.displayTeamData(teamInfo)
            } else {
                self.view?.displayError(message: "Could not load team details.")
            }
        }
    }
}
