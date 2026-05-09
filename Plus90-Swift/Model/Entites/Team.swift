//
//  Team.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import Foundation

struct TeamResponse: Codable {
    let success: Int
    let result: [Team]?
}

struct Team: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?
    let players: [Player]?
    let coaches: [Coach]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}

struct Coach: Codable {
    let coachName: String?
    let coachCountry: String?
    let coachAge: String?
    let coachImage: String?
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
        case coachImage = "coach_image"
    }
}

struct Player: Codable {
    let playerKey: Int
    let playerName: String?
    let playerNumber: String?
    let playerType: String?
    let playerImage: String?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
        case playerImage = "player_image"
    }
}
