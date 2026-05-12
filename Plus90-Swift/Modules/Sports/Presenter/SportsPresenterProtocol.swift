//
//  SportsPresenterProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//


protocol SportsPresenterProtocol {
    func attachView(_ view: SportsViewProtocol)
    func getSportsCount() -> Int
    func getSport(at index: Int) -> Sport
    func didSelectSport(at index: Int)
}
