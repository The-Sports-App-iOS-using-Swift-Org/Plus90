//
//  FavoritesPresenterProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//


protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func getFavoritesCount() -> Int
    func getFavoriteItem(at index: Int) -> FavoriteLeague
    func didSelectFavorite(at index: Int)
    func didRequestRemoval(at index: Int)
    func confirmRemoval(at index: Int)
}