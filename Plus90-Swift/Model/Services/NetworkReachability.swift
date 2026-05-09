//
//  NetworkReachability.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import Network

class NetworkReachability {
    static let shared = NetworkReachability()
    private let monitor = NWPathMonitor()
    var isConnected: Bool = false

    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
