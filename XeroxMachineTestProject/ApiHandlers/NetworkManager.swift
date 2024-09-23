//
//  NetworkManager.swift
//  XeroxMachineTestProject
//
//  Created by Karan on 19/09/24.
//

import Foundation
import Network

class NetworkManager {
    static let shared = NetworkManager()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown

    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }

    func startMonitor(){
        monitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                NotificationCenter.default.post(name: .networkNotReachable, object: nil, userInfo: ["status": true])
            }
        }
        monitor.start(queue: queue)
    }
    

    public func stopMonitoring() {
        monitor.cancel()
    }

    private func detectConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
}
extension Notification.Name{
    static let networkNotReachable = Notification.Name("networkNotReachable")
}
