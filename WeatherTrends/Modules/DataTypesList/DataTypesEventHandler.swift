//
//  DataTypesEventHandler.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

struct DataTypesEventHandler {    
    let output: DataTypesUseCase
    let navigator: DataTypesNavigator
    
    func fetchWeatherData() {
        App.weather.getWeatherData() {
            result in
            self.handle(result: result)
        }
    }
}


fileprivate extension DataTypesEventHandler {
    
    func handle(result:Result<[MonthWithProperties], CAError>) {
        switch result {
        case .success(let monthList):
            DispatchQueue.main.async {
                self.output.set(data: monthList)
            }
        case .failure(_):
            //handle it in real project
            break
        }
    }
}
