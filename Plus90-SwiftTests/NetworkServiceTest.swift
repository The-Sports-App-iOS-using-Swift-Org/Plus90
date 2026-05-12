//
//  NetworkServiceTest.swift
//  Plus90-SwiftTests
//
//  Created by Nemo on 12/05/2026.
//

import XCTest
@testable import Plus90_Swift

final class NetworkServiceTests: XCTestCase {

    var sut: NetworkService!

    override func setUp() {
        super.setUp()
        sut = NetworkService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // Async helpers
    // Wrap every completion-based method once, then call the clean async version in every test

    func fetchFootballLeagues() async -> LeagueResponse? {
        await withCheckedContinuation { continuation in
            sut.fetchFootBallLeagues { continuation.resume(returning: $0) }
        }
    }

    func fetchTennisLeagues() async -> LeagueResponse? {
        await withCheckedContinuation { continuation in
            sut.fetchTennisLeagues { continuation.resume(returning: $0) }
        }
    }

    func fetchBasketballLeagues() async -> LeagueResponse? {
        await withCheckedContinuation { continuation in
            sut.fetchBasketBallLeagues { continuation.resume(returning: $0) }
        }
    }

    func fetchCricketLeagues() async -> LeagueResponse? {
        await withCheckedContinuation { continuation in
            sut.fetchCricketLeagues { continuation.resume(returning: $0) }
        }
    }

    func fetchTeams(leagueId: Int) async -> TeamResponse? {
        await withCheckedContinuation { continuation in
            sut.fetchTeams(leagueId: leagueId) { continuation.resume(returning: $0) }
        }
    }

    func fetchTeamDetails(teamId: Int) async -> Team? {
        await withCheckedContinuation { continuation in
            sut.fetchTeamDetails(teamId: teamId) { continuation.resume(returning: $0) }
        }
    }


    func fetchLatestEvents(leagueId: Int) async -> H2HResponse? {
        await withCheckedContinuation { continuation in
            sut.fetchLatestEvents(leagueId: leagueId) { continuation.resume(returning: $0) }
        }
    }

    func fetchUpcomingEvents(leagueId: Int) async -> H2HResponse? {
        await withCheckedContinuation { continuation in
            sut.fetchUpcomingEvents(leagueId: leagueId) { continuation.resume(returning: $0) }
        }
    }

    // fetchFootBallLeagues

    func testFetchFootballLeagues_ResponseIsNotNil() async {
        let response = await fetchFootballLeagues()
        XCTAssertNotNil(response, "Football leagues response should not be nil")
    }

    func testFetchFootballLeagues_SuccessIsOne() async {
        let response = await fetchFootballLeagues()
        XCTAssertEqual(response?.success, 1)
    }

    func testFetchFootballLeagues_ResultNotEmpty() async {
        let response = await fetchFootballLeagues()
        XCTAssertFalse(response?.result?.isEmpty ?? true,
                       "Football leagues should contain at least one league")
    }

    // fetchTennisLeagues

    func testFetchTennisLeagues_ResponseIsNotNil() async {
        let response = await fetchTennisLeagues()
        XCTAssertNotNil(response)
    }

    func testFetchTennisLeagues_SuccessIsOne() async {
        let response = await fetchTennisLeagues()
        XCTAssertEqual(response?.success, 1)
    }

    func testFetchTennisLeagues_ResultNotEmpty() async {
        let response = await fetchTennisLeagues()
        XCTAssertFalse(response?.result?.isEmpty ?? true)
    }

    // fetchBasketBallLeagues

    func testFetchBasketballLeagues_ResponseIsNotNil() async {
        let response = await fetchBasketballLeagues()
        XCTAssertNotNil(response)
    }

    func testFetchBasketballLeagues_SuccessIsOne() async {
        let response = await fetchBasketballLeagues()
        XCTAssertEqual(response?.success, 1)
    }

    func testFetchBasketballLeagues_ResultNotEmpty() async {
        let response = await fetchBasketballLeagues()
        XCTAssertFalse(response?.result?.isEmpty ?? true)
    }

    // fetchCricketLeagues

    func testFetchCricketLeagues_ResponseIsNotNil() async {
        let response = await fetchCricketLeagues()
        XCTAssertNotNil(response)
    }

    func testFetchCricketLeagues_SuccessIsOne() async {
        let response = await fetchCricketLeagues()
        XCTAssertEqual(response?.success, 1)
    }

    func testFetchCricketLeagues_ResultNotEmpty() async {
        let response = await fetchCricketLeagues()
        XCTAssertFalse(response?.result?.isEmpty ?? true)
    }

    // fetchTeams

    func testFetchTeams_ResponseIsNotNil() async {
        let response = await fetchTeams(leagueId: 148)
        XCTAssertNotNil(response)
    }

    func testFetchTeams_SuccessIsOne() async {
        let response = await fetchTeams(leagueId: 148)
        XCTAssertEqual(response?.success, 1)
    }

    func testFetchTeams_ResultNotEmpty() async {
        let response = await fetchTeams(leagueId: 148)
        XCTAssertFalse(response?.result?.isEmpty ?? true,
                       "Teams result should not be empty for a valid league")
    }

    func testFetchTeams_EachTeamHasName() async {
        let response = await fetchTeams(leagueId: 148)
        guard let teams = response?.result else {
            XCTFail("Expected teams but got nil")
            return
        }
        for team in teams {
            XCTAssertNotNil(team.teamName)
            XCTAssertFalse(team.teamName.isEmpty)
        }
    }

    // fetchTeamDetails

    func testFetchTeamDetails_ReturnsTeam() async {
        let team = await fetchTeamDetails(teamId: 85)
        XCTAssertNotNil(team, "Team details should not be nil for a valid teamId")
    }

    func testFetchTeamDetails_TeamKeyMatchesRequest() async {
        let team = await fetchTeamDetails(teamId: 85)
        XCTAssertEqual(team?.teamKey, 85)
    }

    func testFetchTeamDetails_TeamNameIsNotEmpty() async {
        let team = await fetchTeamDetails(teamId: 85)
        XCTAssertFalse(team?.teamName.isEmpty ?? true)
    }


    // fetchLatestEvents

    func testFetchLatestEvents_ResponseIsNotNil() async {
        let response = await fetchLatestEvents(leagueId: 148)
        XCTAssertNotNil(response)
    }

    func testFetchLatestEvents_SuccessIsOne() async {
        let response = await fetchLatestEvents(leagueId: 148)
        XCTAssertEqual(response?.success, 1)
    }

    func testFetchLatestEvents_NilMeansUrlOrDateMalformed() async {
        let response = await fetchLatestEvents(leagueId: 148)
        if response == nil {
            XCTFail("fetchLatestEvents returned nil — check date formatting or URL construction")
        }
    }

    // fetchUpcomingEvents

    func testFetchUpcomingEvents_ResponseIsNotNil() async {
        let response = await fetchUpcomingEvents(leagueId: 148)
        XCTAssertNotNil(response)
    }

    func testFetchUpcomingEvents_SuccessIsOne() async {
        let response = await fetchUpcomingEvents(leagueId: 148)
        XCTAssertEqual(response?.success, 1)
    }

    func testFetchUpcomingEvents_NilMeansUrlOrDateMalformed() async {
        let response = await fetchUpcomingEvents(leagueId: 148)
        if response == nil {
            XCTFail("fetchUpcomingEvents returned nil — check date formatting or URL construction")
        }
    }
}
