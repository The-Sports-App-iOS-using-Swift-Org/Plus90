//
//  NetworkServiceTest.swift
//  Plus90-SwiftTests
//
//  Created by Nemo on 12/05/2026.


import XCTest
@testable import Plus90_Swift

// Integration Tests  (real network, XCTestExpectation)

final class NetworkServiceIntegrationTests: XCTestCase {

    var sut: NetworkService!

    override func setUp() {
        super.setUp()
        sut = NetworkService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // fetchFootBallLeagues

    func testReal_FootballLeagues_ResponseNotNil() {
        let exp = expectation(description: "Football Leagues")
        sut.fetchFootBallLeagues { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertFalse(response?.result?.isEmpty ?? true)
            XCTAssertNotNil(response?.result?.first?.leagueName)
            XCTAssertNotNil(response?.result?.first?.leagueKey)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    // fetchTennisLeagues

    func testReal_TennisLeagues_ResponseNotNil() {
        let exp = expectation(description: "Tennis Leagues")
        sut.fetchTennisLeagues { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertFalse(response?.result?.isEmpty ?? true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    // fetchBasketBallLeagues

    func testReal_BasketballLeagues_ResponseNotNil() {
        let exp = expectation(description: "Basketball Leagues")
        sut.fetchBasketBallLeagues { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertFalse(response?.result?.isEmpty ?? true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    // fetchCricketLeagues

    func testReal_CricketLeagues_ResponseNotNil() {
        let exp = expectation(description: "Cricket Leagues")
        sut.fetchCricketLeagues { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertFalse(response?.result?.isEmpty ?? true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    // fetchLatestEvents

    func testReal_LatestEvents_ResponseNotNil() {
        let exp = expectation(description: "Latest Events")
        sut.fetchLatestEvents(leagueId: 152) { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertNotNil(response?.result)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    func testReal_LatestEvents_DateRangeIsCorrect() {
        let exp = expectation(description: "Latest Events date range")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let fifteenDaysAgo = Calendar.current.date(byAdding: .day, value: -15, to: Date())!

        sut.fetchLatestEvents(leagueId: 152) { response in
            if let events = response?.result, !events.isEmpty {
                for event in events {
                    if let dateStr = event.eventDate,
                       let date = formatter.date(from: dateStr) {
                        XCTAssertGreaterThanOrEqual(
                            date, fifteenDaysAgo,
                            "Event \(dateStr) is outside the 15-day window"
                        )
                    }
                }
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    // fetchTeams
   
    func testReal_Teams_ResponseNotNil() {
        let exp = expectation(description: "Teams")
        sut.fetchTeams(leagueId: 152) { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertFalse(response?.result?.isEmpty ?? true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    // fetchTeamDetails
   
    func testReal_TeamDetails_ResponseNotNil() {
        let exp = expectation(description: "Team Details")
        sut.fetchTeamDetails(teamId: 85) { team in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    // fetchUpcomingEvents

    func testReal_UpcomingEvents_ResponseNotNil() {
        let exp = expectation(description: "Upcoming Events")
        sut.fetchUpcomingEvents(leagueId: 152) { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertNotNil(response?.result)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }

    func testReal_UpcomingEvents_DateRangeIsCorrect() {
        let exp = expectation(description: "Upcoming Events date range")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today         = Calendar.current.startOfDay(for: Date())
        let twentyDaysOut = Calendar.current.date(byAdding: .day, value: 20, to: today)!

        sut.fetchUpcomingEvents(leagueId: 152) { response in
            if let events = response?.result, !events.isEmpty {
                for event in events {
                    if let dateStr = event.eventDate,
                       let date = formatter.date(from: dateStr) {
                        XCTAssertGreaterThanOrEqual(
                            date, today,
                            "Event \(dateStr) is in the past"
                        )
                        XCTAssertLessThanOrEqual(
                            date, twentyDaysOut,
                            "Event \(dateStr) is beyond the 20-day window"
                        )
                    }
                }
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }
}
