//
//  Service.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/29/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

let NetworkServiceID = "NetworkService"

protocol NetworkService: Service  {
    func doGet(request: NetworkRequest, completionHandler: @escaping (NetworkResponse) -> Void) throws
}

extension App {
    private static let networkServiceNull: NetworkService = NetworkServiceNull()
    
    class func setNetworkService(_ networkService: NetworkService) {
        App.add(networkService, named: NetworkServiceID)
    }
    
    class var network: NetworkService {
        return App.get(NetworkServiceID) as? NetworkService ?? networkServiceNull
    }
}

fileprivate class NetworkServiceNull: NetworkService {
    
    func doGet(request: NetworkRequest, completionHandler: @escaping (NetworkResponse) -> Void) throws { }
    var isRunning: Bool = false
}
