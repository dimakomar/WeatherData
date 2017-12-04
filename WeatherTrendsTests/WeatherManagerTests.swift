//
//  WeatherManagerTests.swift
//  WeatherTrendsTests
//
//  Created by Dima Komar  on 12/3/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import XCTest

class WeatherManagerTests: XCTestCase {
    
    var weatherService: WeatherService?
    let network = TestNetworkManager()
    
    override func setUp() {
        super.setUp()
        self.weatherService = WeatherManager()
        self.weatherService?.start()
        App.setNetworkService(self.network)
    }
    
    override func tearDown() {
        super.tearDown()
        self.weatherService?.stop()
        self.weatherService = nil
    }
    
    func testGetWeatherData() {
        guard let service = self.weatherService else {
            return
        }
        let month = Month(year: 1, month: 1, tMax: "", tMin: "", afDays: "", rainMm: "", sunHours: "")
        let monthes = MonthList(months: [month])
        let encodedObj =  try! monthes.encode()
       
        self.network.response = NetworkResponse(responseData: .responseData(encodedObj), responseError: nil, communicationError: nil, statusCode: 200)
        service.getWeatherData() {
            result in
            if case .failure(_) = result {
                XCTFail("expected to fetch get weather data")
            }
        }
    }
    
    func testGetWeatherDataFailed() {
        guard let service = self.weatherService else {
            return
        }
        self.network.response = NetworkResponse(responseData: .nilData, responseError: nil, communicationError: NSError(domain: "horse", code: 9), statusCode: 200)
        service.getWeatherData() {
            result in
            if case .success(_) = result {
                XCTFail("expected to Fail")
            }
        }
    }
    
    func testGetWeatherDataBadStatusCode() {
        guard let service = self.weatherService else {
            return
        }
        self.network.response = NetworkResponse(responseData: .nilData, responseError: nil, communicationError: NSError(domain: "horse", code: 9), statusCode: 501)
        service.getWeatherData() {
            result in
            if case .success(_) = result {
                XCTFail("expected to Fail")
            }
        }
    }
    
}
