//
//  LeaguesDetailsPresenterProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//

protocol LeaguesDetailsPresenterProtocol{
    func loadData()
    func toggleFavorite(name: String, region: String, image: String)
    func checkFavoriteStatus(name: String)
}
