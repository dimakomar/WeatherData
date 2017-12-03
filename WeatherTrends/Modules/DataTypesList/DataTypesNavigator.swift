//
//  DataTypesNavigator.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

struct DataTypesNavigator: Navigator {
    
    let viewController: UIViewController
    
    func pushChart(values: [MonthWithProperties], year: Int) {
        let years = values.filter() { $0.year == year }
        let chartController = ChartListFacroty.makeChartListViewController()
        chartController.monthsList = years
        push(chartController)
    }
}
