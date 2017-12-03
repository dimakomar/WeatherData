//
//  ChartViewController.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/29/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import UIKit
import JBChartView

enum ChartView {
    static let mainColor = UIColor(netHex: 0x006fff)
    static let fontSize: CGFloat = 24
    static let minTemperatureText = "Min Temperature"
    static let maxTemperatureText = "Max Temperature"
    static let insert: CGFloat = 15.0
}

class ChartViewController: UIViewController {
    var dataSource: ChartViewDataSource!
    let chartView: JBBarChartView = {
        let ret = JBBarChartView(frame: CGRect.zero)
        return ret
    }()
    
    let headerLabel: UILabel = {
        let ret = UILabel(frame: CGRect.zero)
        ret.adjustsFontSizeToFitWidth = true
        ret.textColor = ChartView.mainColor
        ret.font = UIFont.systemFont(ofSize: ChartView.fontSize, weight: .medium)
        return ret
    }()
    
    let valueLabel: UILabel = {
        let ret = UILabel(frame: CGRect.zero)
        ret.adjustsFontSizeToFitWidth = true
        ret.textColor = ChartView.mainColor
        ret.font = UIFont.systemFont(ofSize: ChartView.fontSize, weight: .light)
        return ret
    }()
    
    var monthsList: [MonthWithProperties]!
    var contentView: UIView!
    var chartType: ChartType!
    var chartData: [CGFloat]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view)
    }
    
    override func loadView() {
        super.loadView()
        headerLabel.frame = CGRect(x: ChartView.insert, y: 0, width: self.contentView.frame.width - ChartView.insert * 2, height: self.contentView.frame.height / 8)
        valueLabel.frame = CGRect(x: ChartView.insert, y: headerLabel.frame.height, width: self.contentView.frame.width - ChartView.insert * 2, height: self.contentView.frame.height / 8)
        chartView.frame = CGRect(x: ChartView.insert, y: valueLabel.frame.maxY, width: self.contentView.frame.width - ChartView.insert * 2, height: self.contentView.frame.height - self.contentView.frame.height / 4)
        dataSource = ChartViewDataSource(monthsList: monthsList)
        chartView.delegate = self
        chartView.dataSource = dataSource
        chartView.backgroundColor = .white
        view.addSubview(headerLabel)
        view.addSubview(valueLabel)
        view.addSubview(chartView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadValues(values: monthsList)
        chartView.state = .expanded
    }
}

private extension ChartViewController{
    func loadValues(values: [MonthWithProperties]) {
        switch chartType! {
        case .tMax:
            let newArr = values.map() {$0.tMax.value}
            chartData = newArr
            chartView.maximumValue = CGFloat(getMaxValue(values: newArr))
            chartView.minimumValue = CGFloat(getMinValue(values: newArr))
            headerLabel.text = ChartView.maxTemperatureText
        default:
            let newArr = values.map() {$0.tMin.value}
            chartData = newArr
            chartView.maximumValue = CGFloat(getMaxValue(values: newArr))
            chartView.minimumValue = CGFloat(getMinValue(values: newArr))
            headerLabel.text = ChartView.minTemperatureText
        }
        self.chartView.reloadData()
    }
    
    func getMaxValue(values: [CGFloat]) -> CGFloat {
        var maxTemp: CGFloat = 0.0
        values.forEach() {
            val in
            if val > maxTemp && val > 0 {
                maxTemp = val
            }
        }
        return CGFloat(maxTemp)
    }
    
    func getMinValue(values: [CGFloat]) -> CGFloat {
        var minValue: CGFloat = 0.0
        values.forEach() {
            val in
            if val < minValue && val > 0 {
                minValue = val
            }
        }
        return CGFloat(minValue)
    }    
}

extension ChartViewController: JBBarChartViewDelegate {
    func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        var value = chartData[Int(index)]
        if value <= 0.0 {
            value = 0.0
        }
        return value
    }
    
    func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        var isEstimated = false
        switch chartType! {
        case .tMax:
            isEstimated = monthsList[Int(index)].tMax.isEstimated
        default:
            isEstimated = monthsList[Int(index)].tMin.isEstimated
        }
        
        return isEstimated ? .red : UIColor(netHex: 0x006fff)
    }
    
    func barSelectionColor(for barChartView: JBBarChartView!) -> UIColor! {
        return UIColor(netHex: 0x00fff6)
    }
    
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt) {
        self.valueLabel.text = String(describing: chartData[Int(index)])
    }
}


