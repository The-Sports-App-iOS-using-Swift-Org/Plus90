//
//  NetworkService.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchFootBallLeagues(completion: @escaping (LeagueResponse?) -> Void)
    func fetchTennisLeagues(completion: @escaping (LeagueResponse?) -> Void)
    func fetchBasketBallLeagues(completion: @escaping (LeagueResponse?) -> Void)
    func fetchCricketLeagues(completion: @escaping (LeagueResponse?) -> Void)
    func fetchH2H(firstId: Int, secondId: Int, completion: @escaping (H2HResponse?) -> Void)
    
    func fetchLatestEvents(leagueId: Int, completion: @escaping (H2HResponse?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "f53e0b0a6b8c53985ca5b20708c34bdb7ad3cff2465075297be0bada5f7b0983"
    private let baseUrl = "https://apiv2.allsportsapi.com/"

    // MARK: - Generic League Fetcher
    private func fetchLeagues(for sport: String, completion: @escaping (LeagueResponse?) -> Void) {
        let urlString = "\(baseUrl)\(sport)/?met=Leagues&APIkey=\(apiKey)"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: LeagueResponse.self) { response in
                switch response.result {
                case .success(let leaguesResult):
                    completion(leaguesResult)
                case .failure(let error):
                    print("Error fetching \(sport): \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }

    func fetchFootBallLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchLeagues(for: "football", completion: completion)
    }

    func fetchTennisLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchLeagues(for: "tennis", completion: completion)
    }

    func fetchBasketBallLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchLeagues(for: "basketball", completion: completion)
    }

    func fetchCricketLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        fetchLeagues(for: "cricket", completion: completion)
    }

    func fetchH2H(firstId: Int, secondId: Int, completion: @escaping (H2HResponse?) -> Void) {
        let urlString = "\(baseUrl)football/?met=H2H&APIkey=\(apiKey)&firstTeamId=\(firstId)&secondTeamId=\(secondId)"
        AF.request(urlString).validate().responseDecodable(of: H2HResponse.self) { response in
            completion(response.value)
        }
    }

    func fetchLatestEvents(leagueId: Int, completion: @escaping (H2HResponse?) -> Void) {
        // We set a date range from 15 days ago to today
        let today = Date()
        let fifteenDaysAgo = Calendar.current.date(byAdding: .day, value: -15, to: today)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let fromDate = formatter.string(from: fifteenDaysAgo)
        let toDate = formatter.string(from: today)

        let urlString = "\(baseUrl)football/?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(apiKey)"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: H2HResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(let error):
                    print("Fixtures Fetch Error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}
