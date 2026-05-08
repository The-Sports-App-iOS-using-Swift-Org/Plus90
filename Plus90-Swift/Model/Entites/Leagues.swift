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
    let leagueName: String
    let countryName: String?
    let leagueLogo: String?

}
