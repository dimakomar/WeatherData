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


private extension DataTypesEventHandler {
    func handle(result:Result<[MonthWithProperties], CAError>) {
        switch result {
        case .success(let monthList):
            DispatchQueue.main.async {
                self.output.set(data: monthList)
                self.output.hideActivityIndicator()
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.output.showError(error: error)
                self.output.hideActivityIndicator()
            }
            break
        }
    }
}
