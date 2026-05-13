//
//  NetworkServiceTest.swift
//  Plus90-SwiftTests
//
//  Created by Nemo on 12/05/2026.
//


import XCTest
@testable import Plus90_Swift

final class NetworkServiceMockTests: XCTestCase {

    var mock: MockNetworkService!

    override func setUp() {
        super.setUp()
        mock = MockNetworkService()
    }

    override func tearDown() {
        mock = nil
        super.tearDown()
    }

    func testFootball_Success_ResponseNotNil() {
        mock.fetchFootBallLeagues { XCTAssertNotNil($0) }
    }

    func testFootball_Success_SuccessFlagIsOne() {
        mock.fetchFootBallLeagues { XCTAssertEqual($0?.success, 1) }
    }

    func testFootball_Success_ResultNotEmpty() {
        mock.fetchFootBallLeagues { XCTAssertFalse($0?.result?.isEmpty ?? true) }
    }

    func testFootball_Success_ResultCount() {
        mock.fetchFootBallLeagues { XCTAssertEqual($0?.result?.count, 2) }
    }

    func testFootball_Success_FirstLeagueName() {
        mock.fetchFootBallLeagues { XCTAssertEqual($0?.result?.first?.leagueName, "Premier League") }
    }

    func testFootball_Success_FirstLeagueKey() {
        mock.fetchFootBallLeagues { XCTAssertEqual($0?.result?.first?.leagueKey, 152) }
    }

    func testFootball_Success_FirstLeagueCountry() {
        mock.fetchFootBallLeagues { XCTAssertEqual($0?.result?.first?.countryName, "England") }
    }

    func testFootball_Success_FirstLeagueLogo() {
        mock.fetchFootBallLeagues { XCTAssertNotNil($0?.result?.first?.leagueLogo) }
    }

    func testFootball_Success_SecondLeagueName() {
        mock.fetchFootBallLeagues { XCTAssertEqual($0?.result?.last?.leagueName, "La Liga") }
    }

    func testFootball_Success_SecondLeagueLogoIsNil() {
        // La Liga stub has nil logo — tests optional field handling
        mock.fetchFootBallLeagues { XCTAssertNil($0?.result?.last?.leagueLogo) }
    }

    func testFootball_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchFootBallLeagues { XCTAssertNil($0) }
    }

    func testFootball_EmptyResult_ResponseNotNil() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchFootBallLeagues { XCTAssertNotNil($0) }
    }

    func testFootball_EmptyResult_CountIsZero() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchFootBallLeagues { XCTAssertEqual($0?.result?.count, 0) }
    }

    func testFootball_CallCount_Single() {
        mock.fetchFootBallLeagues { _ in }
        XCTAssertEqual(mock.fetchFootBallLeaguesCallCount, 1)
        XCTAssertTrue(mock.fetchFootBallLeaguesCalled)
    }

    func testFootball_CallCount_Multiple() {
        mock.fetchFootBallLeagues { _ in }
        mock.fetchFootBallLeagues { _ in }
        XCTAssertEqual(mock.fetchFootBallLeaguesCallCount, 2)
    }

    // fetchTennisLeagues

    func testTennis_Success_ResponseNotNil() {
        mock.fetchTennisLeagues { XCTAssertNotNil($0) }
    }

    func testTennis_Success_SuccessFlagIsOne() {
        mock.fetchTennisLeagues { XCTAssertEqual($0?.success, 1) }
    }

    func testTennis_Success_FirstLeagueName() {
        mock.fetchTennisLeagues { XCTAssertEqual($0?.result?.first?.leagueName, "Premier League") }
    }

    func testTennis_Success_ResultNotEmpty() {
        mock.fetchTennisLeagues { XCTAssertFalse($0?.result?.isEmpty ?? true) }
    }

    func testTennis_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchTennisLeagues { XCTAssertNil($0) }
    }

    func testTennis_EmptyResult_CountIsZero() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchTennisLeagues { XCTAssertEqual($0?.result?.count, 0) }
    }

    func testTennis_CallCount_Single() {
        mock.fetchTennisLeagues { _ in }
        XCTAssertTrue(mock.fetchTennisLeaguesCalled)
        XCTAssertEqual(mock.fetchTennisLeaguesCallCount, 1)
    }

    // fetchBasketBallLeagues

    func testBasketball_Success_ResponseNotNil() {
        mock.fetchBasketBallLeagues { XCTAssertNotNil($0) }
    }

    func testBasketball_Success_SuccessFlagIsOne() {
        mock.fetchBasketBallLeagues { XCTAssertEqual($0?.success, 1) }
    }

    func testBasketball_Success_ResultNotEmpty() {
        mock.fetchBasketBallLeagues { XCTAssertFalse($0?.result?.isEmpty ?? true) }
    }

    func testBasketball_Success_FirstLeagueKey() {
        mock.fetchBasketBallLeagues { XCTAssertEqual($0?.result?.first?.leagueKey, 152) }
    }

    func testBasketball_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchBasketBallLeagues { XCTAssertNil($0) }
    }

    func testBasketball_EmptyResult_CountIsZero() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchBasketBallLeagues { XCTAssertEqual($0?.result?.count, 0) }
    }

    func testBasketball_CallCount_Single() {
        mock.fetchBasketBallLeagues { _ in }
        XCTAssertTrue(mock.fetchBasketBallLeaguesCalled)
        XCTAssertEqual(mock.fetchBasketBallLeaguesCallCount, 1)
    }

    // fetchCricketLeagues

    func testCricket_Success_ResponseNotNil() {
        mock.fetchCricketLeagues { XCTAssertNotNil($0) }
    }

    func testCricket_Success_SuccessFlagIsOne() {
        mock.fetchCricketLeagues { XCTAssertEqual($0?.success, 1) }
    }

    func testCricket_Success_ResultNotEmpty() {
        mock.fetchCricketLeagues { XCTAssertFalse($0?.result?.isEmpty ?? true) }
    }

    func testCricket_Success_SecondLeagueName() {
        mock.fetchCricketLeagues { XCTAssertEqual($0?.result?.last?.leagueName, "La Liga") }
    }

    func testCricket_Success_SecondLeagueCountry() {
        mock.fetchCricketLeagues { XCTAssertEqual($0?.result?.last?.countryName, "Spain") }
    }

    func testCricket_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchCricketLeagues { XCTAssertNil($0) }
    }

    func testCricket_EmptyResult_CountIsZero() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchCricketLeagues { XCTAssertEqual($0?.result?.count, 0) }
    }

    func testCricket_CallCount_Single() {
        mock.fetchCricketLeagues { _ in }
        XCTAssertTrue(mock.fetchCricketLeaguesCalled)
        XCTAssertEqual(mock.fetchCricketLeaguesCallCount, 1)
    }

    // fetchLatestEvents

    func testLatestEvents_Success_ResponseNotNil() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertNotNil($0) }
    }

    func testLatestEvents_Success_SuccessFlagIsOne() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.success, 1) }
    }

    func testLatestEvents_Success_ResultNotEmpty() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertFalse($0?.result?.isEmpty ?? true) }
    }

    func testLatestEvents_Success_EventKey() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventKey, 101) }
    }

    func testLatestEvents_Success_HomeTeam() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventHomeTeam, "Arsenal") }
    }

    func testLatestEvents_Success_AwayTeam() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventAwayTeam, "Chelsea") }
    }

    func testLatestEvents_Success_FinalResult() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventFinalResult, "2-1") }
    }

    func testLatestEvents_Success_EventStatus() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventStatus, "Finished") }
    }

    func testLatestEvents_Success_EventDate() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventDate, "2026-05-10") }
    }

    func testLatestEvents_Success_EventTime() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventTime, "20:00") }
    }

    func testLatestEvents_Success_LeagueName() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.leagueName, "Premier League") }
    }

    func testLatestEvents_Success_HomeTeamLogoIsNil() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertNil($0?.result?.first?.homeTeamLogo) }
    }

    func testLatestEvents_Success_AwayTeamLogoIsNil() {
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertNil($0?.result?.first?.awayTeamLogo) }
    }

    func testLatestEvents_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertNil($0) }
    }

    func testLatestEvents_EmptyResult_CountIsZero() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertEqual($0?.result?.count, 0) }
    }

    func testLatestEvents_EmptyResult_ResponseNotNil() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchLatestEvents(leagueId: 152) { XCTAssertNotNil($0) }
    }

    func testLatestEvents_CapturesLeagueId() {
        mock.fetchLatestEvents(leagueId: 42) { _ in }
        XCTAssertEqual(mock.capturedLeagueId, 42)
    }

    func testLatestEvents_CapturesMultipleLeagueIds() {
        mock.fetchLatestEvents(leagueId: 10) { _ in }
        mock.fetchLatestEvents(leagueId: 20) { _ in }
        XCTAssertEqual(mock.capturedLeagueIds, [10, 20])
    }

    func testLatestEvents_CallCount_Single() {
        mock.fetchLatestEvents(leagueId: 1) { _ in }
        XCTAssertTrue(mock.fetchLatestEventsCalled)
        XCTAssertEqual(mock.fetchLatestEventsCallCount, 1)
    }

    // fetchUpcomingEvents

    func testUpcomingEvents_Success_ResponseNotNil() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertNotNil($0) }
    }

    func testUpcomingEvents_Success_SuccessFlagIsOne() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.success, 1) }
    }

    func testUpcomingEvents_Success_ResultNotEmpty() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertFalse($0?.result?.isEmpty ?? true) }
    }

    func testUpcomingEvents_Success_EventKey() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventKey, 202) }
    }

    func testUpcomingEvents_Success_HomeTeam() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventHomeTeam, "Liverpool") }
    }

    func testUpcomingEvents_Success_AwayTeam() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventAwayTeam, "Manchester City") }
    }

    func testUpcomingEvents_Success_StatusIsScheduled() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventStatus, "Scheduled") }
    }

    func testUpcomingEvents_Success_EventDate() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventDate, "2026-05-25") }
    }

    func testUpcomingEvents_Success_EventTime() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.eventTime, "15:00") }
    }

    func testUpcomingEvents_Success_LeagueName() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.first?.leagueName, "Premier League") }
    }

    func testUpcomingEvents_Success_FinalResultIsNil() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertNil($0?.result?.first?.eventFinalResult) }
    }

    func testUpcomingEvents_Success_HomeLogoIsNil() {
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertNil($0?.result?.first?.homeTeamLogo) }
    }

    func testUpcomingEvents_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertNil($0) }
    }

    func testUpcomingEvents_EmptyResult_CountIsZero() {
        mock = MockNetworkService(shouldReturnEmptyResult: true)
        mock.fetchUpcomingEvents(leagueId: 152) { XCTAssertEqual($0?.result?.count, 0) }
    }

    func testUpcomingEvents_CapturesLeagueId() {
        mock.fetchUpcomingEvents(leagueId: 55) { _ in }
        XCTAssertEqual(mock.capturedLeagueId, 55)
    }

    func testUpcomingEvents_CallCount_Single() {
        mock.fetchUpcomingEvents(leagueId: 1) { _ in }
        XCTAssertTrue(mock.fetchUpcomingEventsCalled)
        XCTAssertEqual(mock.fetchUpcomingEventsCallCount, 1)
    }

    // fetchTeams

    func testTeams_Success_ResponseNotNil() {
        mock.fetchTeams(leagueId: 152) { XCTAssertNotNil($0) }
    }

    func testTeams_Success_SuccessFlagIsOne() {
        mock.fetchTeams(leagueId: 152) { XCTAssertEqual($0?.success, 1) }
    }

    func testTeams_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchTeams(leagueId: 152) { XCTAssertNil($0) }
    }

    func testTeams_CapturesLeagueId() {
        mock.fetchTeams(leagueId: 99) { _ in }
        XCTAssertEqual(mock.capturedLeagueId, 99)
    }

    func testTeams_CallCount_Single() {
        mock.fetchTeams(leagueId: 1) { _ in }
        XCTAssertTrue(mock.fetchTeamsCalled)
        XCTAssertEqual(mock.fetchTeamsCallCount, 1)
    }

    // fetchTeamDetails

    func testTeamDetails_Failure_ReturnsNil() {
        mock = MockNetworkService(shouldReturnError: true)
        mock.fetchTeamDetails(teamId: 10) { XCTAssertNil($0) }
    }

    func testTeamDetails_CapturesTeamId() {
        mock.fetchTeamDetails(teamId: 77) { _ in }
        XCTAssertEqual(mock.capturedTeamId, 77)
    }

    func testTeamDetails_CapturesMultipleTeamIds() {
        mock.fetchTeamDetails(teamId: 11) { _ in }
        mock.fetchTeamDetails(teamId: 22) { _ in }
        XCTAssertEqual(mock.capturedTeamIds, [11, 22])
    }

    func testTeamDetails_CallCount_Single() {
        mock.fetchTeamDetails(teamId: 10) { _ in }
        XCTAssertTrue(mock.fetchTeamDetailsCalled)
        XCTAssertEqual(mock.fetchTeamDetailsCallCount, 1)
    }

    // Cross-method interaction tests

    func testCallCounts_AreIndependent() {
        mock.fetchFootBallLeagues { _ in }
        mock.fetchTennisLeagues   { _ in }
        mock.fetchTennisLeagues   { _ in }

        XCTAssertEqual(mock.fetchFootBallLeaguesCallCount,   1)
        XCTAssertEqual(mock.fetchTennisLeaguesCallCount,     2)
        XCTAssertEqual(mock.fetchBasketBallLeaguesCallCount, 0)
        XCTAssertEqual(mock.fetchCricketLeaguesCallCount,    0)
    }

    func testLeagueIdHistory_AcrossEventAndTeamMethods() {
        mock.fetchLatestEvents(leagueId: 100)   { _ in }
        mock.fetchTeams(leagueId: 200)           { _ in }
        mock.fetchUpcomingEvents(leagueId: 300)  { _ in }

        XCTAssertEqual(mock.capturedLeagueIds.count, 3)
        XCTAssertTrue(mock.capturedLeagueIds.contains(100))
        XCTAssertTrue(mock.capturedLeagueIds.contains(200))
        XCTAssertTrue(mock.capturedLeagueIds.contains(300))
    }

    func testLatestAndUpcoming_ReturnDifferentEventData() {
        var latestStatus:   String?
        var upcomingStatus: String?

        mock.fetchLatestEvents(leagueId: 1)   { latestStatus   = $0?.result?.first?.eventStatus }
        mock.fetchUpcomingEvents(leagueId: 1)  { upcomingStatus = $0?.result?.first?.eventStatus }

        XCTAssertEqual(latestStatus,   "Finished")
        XCTAssertEqual(upcomingStatus, "Scheduled")
        XCTAssertNotEqual(latestStatus, upcomingStatus)
    }

    func testLatestEvent_HasFinalResult_UpcomingDoesNot() {
        var latestResult:   String?
        var upcomingResult: String?

        mock.fetchLatestEvents(leagueId: 1)   { latestResult   = $0?.result?.first?.eventFinalResult }
        mock.fetchUpcomingEvents(leagueId: 1)  { upcomingResult = $0?.result?.first?.eventFinalResult }

        XCTAssertNotNil(latestResult)
        XCTAssertNil(upcomingResult)
    }
}

