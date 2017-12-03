//
//  WeatherService.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 12/3/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

let WeatherServiceID = "WeatherService"

protocol WeatherService: Service {
    func getWeatherData(completion: @escaping ((Result<[MonthWithProperties], CAError>) -> ()))
}

extension App {
    private static let weatherServiceNull: WeatherService = WeatherServiceNull()
    
    class func setWeatherService(_ weatherService: WeatherService) {
        App.add(weatherService, named: WeatherServiceID)
    }
    
    class var weather: WeatherService {
        return App.get(WeatherServiceID) as? WeatherService ?? weatherServiceNull
    }
}

fileprivate class WeatherServiceNull: WeatherService {
    func getWeatherData(completion: @escaping ((Result<[MonthWithProperties], CAError>) -> ())) {}
    
    var isRunning: Bool = false
}
