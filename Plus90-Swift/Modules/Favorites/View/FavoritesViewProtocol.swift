//
//  FavoritesViewProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//


protocol FavoritesViewProtocol: AnyObject {
    func reloadData()
    func showDeleteConfirmation(at index: Int, leagueName: String)
    func toggleEmptyState(show: Bool)
    func navigateToDetails(with league: FavoriteLeague)
    func showNetworkError()
}
