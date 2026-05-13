//
//  MockNetworkService.swift
//  Plus90-SwiftTests
//
//  Created by Bayoumi on 13/05/2026.
//


import Foundation
@testable import Plus90_Swift

class MockNetworkService: NetworkServiceProtocol {

    var shouldReturnError: Bool
    var shouldReturnEmptyResult: Bool

    var fetchFootBallLeaguesCallCount    = 0
    var fetchTennisLeaguesCallCount      = 0
    var fetchBasketBallLeaguesCallCount  = 0
    var fetchCricketLeaguesCallCount     = 0
    var fetchLatestEventsCallCount       = 0
    var fetchTeamsCallCount              = 0
    var fetchTeamDetailsCallCount        = 0
    var fetchUpcomingEventsCallCount     = 0

    var fetchFootBallLeaguesCalled:   Bool { fetchFootBallLeaguesCallCount   > 0 }
    var fetchTennisLeaguesCalled:     Bool { fetchTennisLeaguesCallCount     > 0 }
    var fetchBasketBallLeaguesCalled: Bool { fetchBasketBallLeaguesCallCount > 0 }
    var fetchCricketLeaguesCalled:    Bool { fetchCricketLeaguesCallCount    > 0 }
    var fetchLatestEventsCalled:      Bool { fetchLatestEventsCallCount      > 0 }
    var fetchTeamsCalled:             Bool { fetchTeamsCallCount             > 0 }
    var fetchTeamDetailsCalled:       Bool { fetchTeamDetailsCallCount       > 0 }
    var fetchUpcomingEventsCalled:    Bool { fetchUpcomingEventsCallCount    > 0 }

    var capturedLeagueIds: [Int] = []
    var capturedTeamIds:   [Int] = []

    var capturedLeagueId: Int? { capturedLeagueIds.last }
    var capturedTeamId:   Int? { capturedTeamIds.last   }


    let stubLeague1 = League(
        leagueKey:   152,
        leagueName:  "Premier League",
        countryName: "England",
        leagueLogo:  "https://example.com/epl.png"
    )

    let stubLeague2 = League(
        leagueKey:   302,
        leagueName:  "La Liga",
        countryName: "Spain",
        leagueLogo:  nil
    )

    let stubFinishedEvent = MatchEvent(
        eventKey:        101,
        eventDate:       "2026-05-10",
        eventTime:       "20:00",
        eventHomeTeam:   "Arsenal",
        eventAwayTeam:   "Chelsea",
        homeTeamLogo:    nil,
        awayTeamLogo:    nil,
        eventFinalResult: "2-1",
        eventStatus:     "Finished",
        leagueName:      "Premier League"
    )

    let stubUpcomingEvent = MatchEvent(
        eventKey:        202,
        eventDate:       "2026-05-25",
        eventTime:       "15:00",
        eventHomeTeam:   "Liverpool",
        eventAwayTeam:   "Manchester City",
        homeTeamLogo:    nil,
        awayTeamLogo:    nil,
        eventFinalResult: nil,
        eventStatus:     "Scheduled",
        leagueName:      "Premier League"
    )

    init(shouldReturnError: Bool = false, shouldReturnEmptyResult: Bool = false) {
        self.shouldReturnError       = shouldReturnError
        self.shouldReturnEmptyResult = shouldReturnEmptyResult
    }

    // Private Helpers
    private func leagueResponse() -> LeagueResponse? {
        guard !shouldReturnError else { return nil }
        let result = shouldReturnEmptyResult ? [] : [stubLeague1, stubLeague2]
        return LeagueResponse(success: 1, result: result)
    }

    private func latestEventsResponse() -> H2HResponse? {
        guard !shouldReturnError else { return nil }
        let result = shouldReturnEmptyResult ? [] : [stubFinishedEvent]
        return H2HResponse(success: 1, result: result)
    }

    private func upcomingEventsResponse() -> H2HResponse? {
        guard !shouldReturnError else { return nil }
        let result = shouldReturnEmptyResult ? [] : [stubUpcomingEvent]
        return H2HResponse(success: 1, result: result)
    }

    private func teamResponse() -> TeamResponse? {
        guard !shouldReturnError else { return nil }
        return TeamResponse(success: 1, result: [])
    }

    // NetworkServiceProtocol
    
    func fetchFootBallLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchFootBallLeaguesCallCount += 1
        completion(leagueResponse())
    }

    func fetchTennisLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchTennisLeaguesCallCount += 1
        completion(leagueResponse())
    }

    func fetchBasketBallLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchBasketBallLeaguesCallCount += 1
        completion(leagueResponse())
    }

    func fetchCricketLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchCricketLeaguesCallCount += 1
        completion(leagueResponse())
    }

    func fetchLatestEvents(leagueId: Int, completion: @escaping (H2HResponse?) -> Void) {
        fetchLatestEventsCallCount += 1
        capturedLeagueIds.append(leagueId)
        completion(latestEventsResponse())
    }

    func fetchTeams(leagueId: Int, completion: @escaping (TeamResponse?) -> Void) {
        fetchTeamsCallCount += 1
        capturedLeagueIds.append(leagueId)
        completion(teamResponse())
    }

    func fetchTeamDetails(teamId: Int, completion: @escaping (Team?) -> Void) {
        fetchTeamDetailsCallCount += 1
        capturedTeamIds.append(teamId)
        completion(nil)
    }

    func fetchUpcomingEvents(leagueId: Int, completion: @escaping (H2HResponse?) -> Void) {
        fetchUpcomingEventsCallCount += 1
        capturedLeagueIds.append(leagueId)
        completion(upcomingEventsResponse())
    }
}
