//
//  MatchEvent.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 08/05/2026.
//

import Foundation

struct H2HResponse: Codable {
    let success: Int
    let result: [MatchEvent]?
}

struct MatchEvent: Codable {
    let eventKey: Int
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let leagueName: String?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
        case leagueName = "league_name"
    }
}

struct H2HData: Codable {
    let firstTeamResults: [MatchEvent]
    let secondTeamResults: [MatchEvent]
    
    enum CodingKeys: String, CodingKey {
        case firstTeamResults = "firstTeamResults"
        case secondTeamResults = "secondTeamResults"
    }
}
