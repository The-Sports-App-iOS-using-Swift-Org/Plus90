//
//  TeamDetailsViewProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//

protocol TeamDetailsViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func displayTeamData(_ team: Team)
    func displayError(message: String)
}
