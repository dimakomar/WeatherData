//
//  NetworkManager.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/29/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

enum DataWrapper {
    case nilData
    case responseData(Any)
}

struct NetworkRequest {
    let requestPath: String
    var requestJSON: [String: Any]?
    var requestBody: String?
    
    init(requestPath: String, requestJSON: [String: Any]? = nil) {
        self.requestPath = requestPath
        self.requestJSON = requestJSON
    }
}

struct NetworkResponse {
    let responseData: DataWrapper
    let communicationError: Error?
    let statusCode: Int
}

class NetworkManager: NetworkService {
    
    var isRunning: Bool = true
    
    fileprivate let dataSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpShouldUsePipelining = true
        config.timeoutIntervalForRequest = 5
        config.timeoutIntervalForResource = 60
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
        ]
        return URLSession(configuration: config)
    }()
    
    func doGet(request: NetworkRequest, completionHandler: @escaping (NetworkResponse) -> Void) throws {
        let session = self.dataSession
        var task: URLSessionDataTask?
        guard let url = URL(string: request.requestPath) else { return }
        let urlRequest = URLRequest(url: url)
        task = session.dataTask(with: urlRequest) {
            data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else {
                completionHandler(NetworkResponse(responseData: DataWrapper.nilData, communicationError: error, statusCode: 500))
                return
            }
            completionHandler(NetworkResponse(responseData: DataWrapper.responseData(data), communicationError: error, statusCode: response.statusCode))
        }
        
        if let t = task {
            t.resume()
        }
    }
}
