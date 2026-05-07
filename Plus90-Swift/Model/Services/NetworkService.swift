//
//  NetworkService.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol{
    func fetchAllLeagues(completion:@escaping(LeagueResponse?)->Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetchAllLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=YOUR_KEY"// this is my
        AF.request(urlString)
            .validate()
            .responseDecodable(of: LeagueResponse.self) { response in
                switch response.result {
                case .success(let leaguesResult):
                    completion(leaguesResult)
                case .failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}
