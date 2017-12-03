//
//  ChartListFacroty.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 12/1/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

struct ChartListFacroty {
    static func makeChartListViewController() -> ChartListTableViewController {
        let chartListViewController = ChartListTableViewController(style: .plain)
        return chartListViewController
    }
}
