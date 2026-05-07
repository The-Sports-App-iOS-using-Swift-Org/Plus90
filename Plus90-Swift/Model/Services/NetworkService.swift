//
//  NetworkService.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import Foundation
protocol NetworkServiceProtocol{
    func fetchAllLeagues(completion:@escaping(LeagueResponse?)->Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetchAllLeagues(completion: @escaping (LeagueResponse?) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=f53e0b0a6b8c53985ca5b20708c34bdb7ad3cff2465075297be0bada5f7b0983" // change the api
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching leagues: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let leaguesResult = try decoder.decode(LeagueResponse.self, from: data)
                completion(leaguesResult)
            } catch let error {
                print("Decoding error: \(error)")
                completion(nil)
            }
            
        }.resume()
    }
}
