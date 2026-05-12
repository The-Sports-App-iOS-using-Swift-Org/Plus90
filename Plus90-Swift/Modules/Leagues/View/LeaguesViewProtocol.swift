//
//  LeaguesViewProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//


protocol LeaguesViewProtocol: AnyObject {
    func startAnimating()
    func stopAnimating()
    func reloadTable()
    func showError(message: String)
}