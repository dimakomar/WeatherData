//
//  DataTypesViewControllerFactory.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

struct DataTypesViewControllerFactory {
    static func makeHomeNavigationController() -> UINavigationController {
        let dataTypesViewController = DataTypesTableViewController(style: .plain)
        dataTypesViewController.output = DataTypesEventHandler(output: dataTypesViewController, navigator: DataTypesNavigator(viewController: dataTypesViewController))
        let navigationController = UINavigationController(rootViewController: dataTypesViewController)
        return navigationController
    }
}
