//
//  ModelTests.swift
//  Plus90-SwiftTests
//
//  Created by Bayoumi on 13/05/2026.
//

import XCTest
@testable import Plus90_Swift


final class ModelTests: XCTestCase {

    func testMatchEvent_AllFieldsSet() {
        let event = MatchEvent(
            eventKey:         99,
            eventDate:        "2026-01-01",
            eventTime:        "18:00",
            eventHomeTeam:    "Home FC",
            eventAwayTeam:    "Away FC",
            homeTeamLogo:     "https://logo.com/home.png",
            awayTeamLogo:     "https://logo.com/away.png",
            eventFinalResult: "3-0",
            eventStatus:      "Finished",
            leagueName:       "Test League"
        )

        XCTAssertEqual(event.eventKey,         99)
        XCTAssertEqual(event.eventDate,        "2026-01-01")
        XCTAssertEqual(event.eventTime,        "18:00")
        XCTAssertEqual(event.eventHomeTeam,    "Home FC")
        XCTAssertEqual(event.eventAwayTeam,    "Away FC")
        XCTAssertEqual(event.homeTeamLogo,     "https://logo.com/home.png")
        XCTAssertEqual(event.awayTeamLogo,     "https://logo.com/away.png")
        XCTAssertEqual(event.eventFinalResult, "3-0")
        XCTAssertEqual(event.eventStatus,      "Finished")
        XCTAssertEqual(event.leagueName,       "Test League")
    }

    func testMatchEvent_AllOptionalFieldsNil() {
        let event = MatchEvent(
            eventKey:         1,
            eventDate:        nil,
            eventTime:        nil,
            eventHomeTeam:    nil,
            eventAwayTeam:    nil,
            homeTeamLogo:     nil,
            awayTeamLogo:     nil,
            eventFinalResult: nil,
            eventStatus:      nil,
            leagueName:       nil
        )

        XCTAssertEqual(event.eventKey, 1)
        XCTAssertNil(event.eventDate)
        XCTAssertNil(event.eventTime)
        XCTAssertNil(event.eventHomeTeam)
        XCTAssertNil(event.eventAwayTeam)
        XCTAssertNil(event.homeTeamLogo)
        XCTAssertNil(event.awayTeamLogo)
        XCTAssertNil(event.eventFinalResult)
        XCTAssertNil(event.eventStatus)
        XCTAssertNil(event.leagueName)
    }

    func testMatchEvent_DecodesFromJSON() throws {
        let json = """
        {
            "event_key": 555,
            "event_date": "2026-06-01",
            "event_time": "21:00",
            "event_home_team": "Barcelona",
            "event_away_team": "Real Madrid",
            "home_team_logo": null,
            "away_team_logo": null,
            "event_final_result": "1-1",
            "event_status": "Finished",
            "league_name": "La Liga"
        }
        """.data(using: .utf8)!

        let event = try JSONDecoder().decode(MatchEvent.self, from: json)

        XCTAssertEqual(event.eventKey,         555)
        XCTAssertEqual(event.eventDate,        "2026-06-01")
        XCTAssertEqual(event.eventTime,        "21:00")
        XCTAssertEqual(event.eventHomeTeam,    "Barcelona")
        XCTAssertEqual(event.eventAwayTeam,    "Real Madrid")
        XCTAssertNil(event.homeTeamLogo)
        XCTAssertNil(event.awayTeamLogo)
        XCTAssertEqual(event.eventFinalResult, "1-1")
        XCTAssertEqual(event.eventStatus,      "Finished")
        XCTAssertEqual(event.leagueName,       "La Liga")
    }

    func testMatchEvent_DecodesFromJSON_AllNilOptionals() throws {
        let json = """
        {
            "event_key": 1
        }
        """.data(using: .utf8)!

        let event = try JSONDecoder().decode(MatchEvent.self, from: json)
        XCTAssertEqual(event.eventKey, 1)
        XCTAssertNil(event.eventDate)
        XCTAssertNil(event.eventFinalResult)
        XCTAssertNil(event.eventStatus)
    }

   // H2HResponse
    func testH2HResponse_DecodesFromJSON_WithEvents() throws {
        let json = """
        {
            "success": 1,
            "result": [
                {
                    "event_key": 10,
                    "event_home_team": "TeamA",
                    "event_away_team": "TeamB",
                    "event_status": "Finished",
                    "event_final_result": "2-0"
                }
            ]
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(H2HResponse.self, from: json)
        XCTAssertEqual(response.success,                       1)
        XCTAssertEqual(response.result?.count,                 1)
        XCTAssertEqual(response.result?.first?.eventHomeTeam,  "TeamA")
        XCTAssertEqual(response.result?.first?.eventAwayTeam,  "TeamB")
        XCTAssertEqual(response.result?.first?.eventFinalResult, "2-0")
    }

    func testH2HResponse_DecodesFromJSON_EmptyResult() throws {
        let json = """
        { "success": 1, "result": [] }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(H2HResponse.self, from: json)
        XCTAssertEqual(response.success,       1)
        XCTAssertEqual(response.result?.count, 0)
    }

    func testH2HResponse_DecodesFromJSON_NilResult() throws {
        let json = """
        { "success": 0 }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(H2HResponse.self, from: json)
        XCTAssertEqual(response.success, 0)
        XCTAssertNil(response.result)
    }

   
    func testLeague_AllFieldsSet() {
        let league = League(
            leagueKey:   1,
            leagueName:  "Premier League",
            countryName: "England",
            leagueLogo:  "https://logo.com/epl.png"
        )

        XCTAssertEqual(league.leagueKey,   1)
        XCTAssertEqual(league.leagueName,  "Premier League")
        XCTAssertEqual(league.countryName, "England")
        XCTAssertEqual(league.leagueLogo,  "https://logo.com/epl.png")
    }

    func testLeague_OptionalFieldsNil() {
        let league = League(
            leagueKey:   2,
            leagueName:  "Unknown League",
            countryName: nil,
            leagueLogo:  nil
        )

        XCTAssertEqual(league.leagueKey,  2)
        XCTAssertEqual(league.leagueName, "Unknown League")
        XCTAssertNil(league.countryName)
        XCTAssertNil(league.leagueLogo)
    }

    func testLeague_DecodesFromJSON() throws {
        let json = """
        {
            "league_key": 152,
            "league_name": "Premier League",
            "country_name": "England",
            "league_logo": "https://logo.com/epl.png"
        }
        """.data(using: .utf8)!

        let league = try JSONDecoder().decode(League.self, from: json)
        XCTAssertEqual(league.leagueKey,   152)
        XCTAssertEqual(league.leagueName,  "Premier League")
        XCTAssertEqual(league.countryName, "England")
        XCTAssertNotNil(league.leagueLogo)
    }

    func testLeague_DecodesFromJSON_NilOptionals() throws {
        let json = """
        {
            "league_key": 1,
            "league_name": "Minimal League"
        }
        """.data(using: .utf8)!

        let league = try JSONDecoder().decode(League.self, from: json)
        XCTAssertEqual(league.leagueKey,  1)
        XCTAssertEqual(league.leagueName, "Minimal League")
        XCTAssertNil(league.countryName)
        XCTAssertNil(league.leagueLogo)
    }

    func testLeagueResponse_DecodesFromJSON() throws {
        let json = """
        {
            "success": 1,
            "result": [
                { "league_key": 1, "league_name": "EPL", "country_name": "England" }
            ]
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(LeagueResponse.self, from: json)
        XCTAssertEqual(response.success,                  1)
        XCTAssertEqual(response.result?.count,            1)
        XCTAssertEqual(response.result?.first?.leagueName, "EPL")
    }

    // H2HData

    func testH2HData_DecodesFromJSON() throws {
        let json = """
        {
            "firstTeamResults":  [ { "event_key": 1, "event_status": "Finished" } ],
            "secondTeamResults": [ { "event_key": 2, "event_status": "Finished" } ]
        }
        """.data(using: .utf8)!

        let data = try JSONDecoder().decode(H2HData.self, from: json)
        XCTAssertEqual(data.firstTeamResults.count,  1)
        XCTAssertEqual(data.secondTeamResults.count, 1)
        XCTAssertEqual(data.firstTeamResults.first?.eventKey,  1)
        XCTAssertEqual(data.secondTeamResults.first?.eventKey, 2)
    }

    func testH2HData_EmptyArrays() throws {
        let json = """
        { "firstTeamResults": [], "secondTeamResults": [] }
        """.data(using: .utf8)!

        let data = try JSONDecoder().decode(H2HData.self, from: json)
        XCTAssertTrue(data.firstTeamResults.isEmpty)
        XCTAssertTrue(data.secondTeamResults.isEmpty)
    }
}
