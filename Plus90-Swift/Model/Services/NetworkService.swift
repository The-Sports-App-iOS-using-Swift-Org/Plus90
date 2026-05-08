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
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "f53e0b0a6b8c53985ca5b20708c34bdb7ad3cff2465075297be0bada5f7b0983"
    private let baseUrl = "https://apiv2.allsportsapi.com/"
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
}
