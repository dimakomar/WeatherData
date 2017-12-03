//
//  Result.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

public enum Result<Value, CAError> {
    
    case success(Value)
    case failure(CAError)
    
    var optionalValue:Value? {
        switch self {
        case .success(let value):   return value
        default:                    return nil
        }
    }
}

public enum CAError: Error {
    case none
    case parsingFailure(message: String, request: String)
    case noData(message: String, request: String)
    case serverFailure(Error)
    case serverRefused(message: String)
    case other(childError: Error)
}
