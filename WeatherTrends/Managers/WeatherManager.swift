//
//  WeatherManager.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 12/3/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import UIKit

enum WeatherManagerConstants {
    static let requestPath = "http://127.0.0.1:8000/get_weather/"
    static let maximumFractionDigits = 1
    static let estimatedDataChar: Character = "*"
}

class WeatherManager: WeatherService {
    var isRunning: Bool = false
    
    func getWeatherData(completion: @escaping ((Result<[MonthWithProperties], CAError>) -> ())) {
        
        let req = NetworkRequest(requestPath: WeatherManagerConstants.requestPath)
        do {
            try App.network.doGet(request: req) {
                response in
                if let error = response.communicationError {
                    completion(.failure(CAError.other(childError: error)))
                    return
                }
                
                let responseData = response.responseData
                switch responseData {
                case .element(let resData):
                    let decoder = JSONDecoder()
                    let months = try! decoder.decode(MonthList.self, from: resData as! Data)
                    let convertedMonth = months.months.map() {
                        month -> MonthWithProperties in
                        
                        let maxTemp = self.createFloat(val: month.tMax)
                        let minTemp = self.createFloat(val: month.tMin)
                        let afDays = self.createFloat(val: month.afDays)
                        let rainMm = self.createFloat(val: month.rainMm)
                        let sunHours = self.createFloat(val: month.sunHours)
                        return MonthWithProperties(year: month.year, month: month.year, tMax: maxTemp, tMin: minTemp, afDays: afDays, rainMm: rainMm, sunHours: sunHours)
                    }
                    completion(.success(convertedMonth))
                case .notSet:
                    completion(.failure(CAError.none))
                case .nilData:
                    completion(.failure(CAError.none))
                case .dictionary(_):
                    completion(.failure(CAError.none))
                case .array(_):
                    completion(.failure(CAError.none))
                }
            }
        } catch {
            completion(.failure(CAError.none))
        }
    }
    
    func createFloat (val: String) -> FloatMonthValue {
        let tMaxValue = val.filter() { $0 != WeatherManagerConstants.estimatedDataChar}
        var convertedValue: FloatMonthValue!
        let formetter = NumberFormatter()
        formetter.maximumFractionDigits = WeatherManagerConstants.maximumFractionDigits
        if let number = formetter.number(from: tMaxValue)?.doubleValue {
            convertedValue = FloatMonthValue(value: CGFloat(number), isEstimated: val.contains(WeatherManagerConstants.estimatedDataChar))
        } else {
            convertedValue = FloatMonthValue(value: 0.0, isEstimated: false)
        }
        return convertedValue
    }
}
