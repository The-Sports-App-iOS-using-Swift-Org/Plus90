//
//  LeaguesDetailsViewProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//


protocol LeaguesDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func refreshUI(upcoming: [MatchEvent], latest: [MatchEvent], teams: [Team])
    func updateFavoriteButton(isFavorite: Bool)
}
