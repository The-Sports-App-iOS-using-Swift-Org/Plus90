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

struct H2HData: Codable {
    let H2H: [MatchEvent]
    let firstTeamResults: [MatchEvent]
    let secondTeamResults: [MatchEvent]
}

struct MatchEvent: Codable {
    let event_key: Int
    let event_date: String
    let event_time: String
    let event_home_team: String
    let event_away_team: String
    let home_team_logo: String?
    let away_team_logo: String?
    let event_final_result: String
    let event_status: String
    let league_name: String
}
