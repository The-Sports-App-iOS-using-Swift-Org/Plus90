//
//  FavoritesPresenter.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 06/05/2026.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getFavoritesCount() -> Int
    func getFavoriteItem(at index: Int) -> FavoriteLeague
    func didSelectLeague(at index: Int)
    func didSelectFavorite(at index: Int)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    private weak var view: FavoritesViewProtocol?
    private var favorites: [FavoriteLeague] = []

    init(view: FavoritesViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        favorites = [
            FavoriteLeague(name: "Premier League", region: "England", imageName: "onboarding1"),
            FavoriteLeague(name: "NBA", region: "United States", imageName: "onboarding1"),
            FavoriteLeague(name: "Champions League", region: "Europe", imageName: "onboarding1"),
            FavoriteLeague(name: "La Liga", region: "Spain", imageName: "onboarding1"),
            FavoriteLeague(name: "EuroLeague", region: "Europe", imageName: "onboarding1"),
            
            FavoriteLeague(name: "La Liga", region: "Spain", imageName: "onboarding1"),
            FavoriteLeague(name: "EuroLeague", region: "Europe", imageName: "onboarding1"),
            FavoriteLeague(name: "La Liga", region: "Spain", imageName: "onboarding1"),
            FavoriteLeague(name: "EuroLeague", region: "Europe", imageName: "onboarding1"),
            FavoriteLeague(name: "La Liga", region: "Spain", imageName: "onboarding1"),
            FavoriteLeague(name: "EuroLeague", region: "Europe", imageName: "onboarding1"),
            FavoriteLeague(name: "La Liga", region: "Spain", imageName: "onboarding1"),
            FavoriteLeague(name: "EuroLeague", region: "Europe", imageName: "onboarding1"),
            FavoriteLeague(name: "La Liga", region: "Spain", imageName: "onboarding1"),
            FavoriteLeague(name: "EuroLeague", region: "Europe", imageName: "onboarding1")
        ]
        view?.reloadData()
    }

    func getFavoritesCount() -> Int {
        return favorites.count
    }

    func getFavoriteItem(at index: Int) -> FavoriteLeague {
        return favorites[index]
    }

    func didSelectLeague(at index: Int) {
        let league = favorites[index]
        print("Navigate to details for: \(league.name)")
    }
    func didSelectFavorite(at index: Int) {
        let selectedLeague = favorites[index]
        print("Navigate to details for: \(selectedLeague.name)")
        
        // Navigation to details if online otherwise show alert
        // view?.navigateToDetails(for: selectedLeague)
    }
}
