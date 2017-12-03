//
//  TestNetworkManager.swift
//  WeatherTrendsTests
//
//  Created by Dima Komar  on 12/3/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation


class TestNetworkManager: NetworkService {
    
    var response: NetworkResponse?
    fileprivate var responses: [NetworkRequest: NetworkResponse] = [:]
    func stub(response: NetworkResponse?, for request: NetworkRequest) {
        responses[request] = response
    }
    
    private(set) var requests = [NetworkRequest]()
    
    func doGet(request: NetworkRequest, completionHandler: @escaping (NetworkResponse) -> Void) throws {
        //        print("doGet")
        requests.append(request)
        let resp = responses[request] ?? self.response
        if let resp = resp {
            completionHandler(resp)
        }
        self.response = nil
    }
    
   
    
    // MARK: Service properties
    let name: String = NetworkServiceID
    var isRunning: Bool = false
    
}


extension NetworkRequest : Hashable {
    var hashValue: Int {
        let relativePath = requestPath.components(separatedBy: "?").first ?? ""
        return relativePath.hash
    }
    
    public static func ==(lhs: NetworkRequest, rhs: NetworkRequest) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
