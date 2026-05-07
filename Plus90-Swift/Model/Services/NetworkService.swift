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
