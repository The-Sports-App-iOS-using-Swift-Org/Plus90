//
//  FavoritesPresenter.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 06/05/2026.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func getFavoritesCount() -> Int
    func getFavoriteItem(at index: Int) -> FavoriteLeague
    func didSelectFavorite(at index: Int)
    func didRequestRemoval(at index: Int)
    func confirmRemoval(at index: Int)
}
class FavoritesPresenter: FavoritesPresenterProtocol {
    private weak var view: FavoritesViewProtocol?
    private var favorites: [FavoriteLeague] = []

    init(view: FavoritesViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        loadData()
    }

    func viewWillAppear() {
        loadData()
    }

    private func loadData() {
        favorites = CoreDataManager.shared.fetchFavorites()
        view?.toggleEmptyState(show: favorites.isEmpty)
        view?.reloadData()
    }

    func getFavoritesCount() -> Int {
        return favorites.count
    }

    func getFavoriteItem(at index: Int) -> FavoriteLeague {
        return favorites[index]
    }

    func didSelectFavorite(at index: Int) {
        let selectedLeague = favorites[index]
        print("Navigate to details for: \(selectedLeague.name)")
    }

    func didRequestRemoval(at index: Int) {
        let league = favorites[index]
        view?.showDeleteConfirmation(at: index, leagueName: league.name)
    }

    func confirmRemoval(at index: Int) {
        let item = favorites[index]
        CoreDataManager.shared.deleteLeague(name: item.name)
        favorites.remove(at: index)
        
        view?.toggleEmptyState(show: favorites.isEmpty)
        view?.reloadData()
    }
}
