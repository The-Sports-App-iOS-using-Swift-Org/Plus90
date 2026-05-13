//
//  League.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation

struct LeagueResponse: Codable {
    let success: Int
    let result: [League]?
}

struct League: Codable {
    let leagueKey: Int
    let leagueName: String
    let countryName: String?
    let leagueLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
    }
}
