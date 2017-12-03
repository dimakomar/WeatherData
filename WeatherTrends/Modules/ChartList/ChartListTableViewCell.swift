//
//  ChartListTableViewCell.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 12/1/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import UIKit
import JBChartView

final class ChartListTableViewCell: UITableViewCell {
    var contentViewController: UIViewController!

    func addViewController(toParentViewController parentViewController: UIViewController, values: [MonthWithProperties], chartType: ChartType) {
        contentViewController = ChartViewControllerFactory.makeChartViewController(values: values, contentView: contentView, chartType: chartType)
        parentViewController.addChildViewController(contentViewController)
        contentViewController.didMove(toParentViewController: parentViewController)
        contentView.addSubview(contentViewController.view)
    }
    
    func removeViewControllerFromParentViewController() {
        contentViewController.view.removeFromSuperview()
        contentViewController.willMove(toParentViewController: nil)
        contentViewController.removeFromParentViewController()
    }
}
