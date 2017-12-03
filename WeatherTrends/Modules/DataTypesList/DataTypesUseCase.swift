//
//  DataTypesUseCase.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

protocol DataTypesUseCase: UITableViewDelegate {
    func hideActivityIndicator()
    func set(data: [MonthWithProperties])
}
