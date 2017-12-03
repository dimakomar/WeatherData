//
//  ChartViewDataSource.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 12/1/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation
import JBChartView

class ChartViewDataSource: NSObject, JBBarChartViewDataSource {
    private var monthsList = [MonthWithProperties]()
    
    init(monthsList: [MonthWithProperties]) {
        self.monthsList = monthsList
    }
    
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
        return UInt(monthsList.count)
    }
    
    func shouldExtendSelectionViewIntoHeaderPadding(for chartView: JBChartView!) -> Bool {
        return true
    }
    
    func shouldExtendSelectionViewIntoFooterPadding(for chartView: JBChartView!) -> Bool {
        return false
    }
}


