//
//  LeaguesPresenterProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//


protocol LeaguesPresenterProtocol {
    func fetchLeagues(for sportName: String)
    func getLeaguesCount() -> Int
    func getLeague(at index: Int) -> League
}
