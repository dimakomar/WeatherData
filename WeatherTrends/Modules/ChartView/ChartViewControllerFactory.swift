//
//  ChartViewControllerFactory.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

struct ChartViewControllerFactory {
    static func makeChartViewController(values: [MonthWithProperties], contentView: UIView, chartType: ChartType) -> ChartViewController {
        let chartViewController = ChartViewController()
        chartViewController.monthsList = values
        chartViewController.contentView = contentView
        chartViewController.chartType = chartType
        return chartViewController
    }
}
