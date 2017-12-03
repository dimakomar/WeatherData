//
//  DataTypesTableViewController.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

enum DataTypesList {
    static let navigationBarTitleText = "Years"
    static let reuseId = "DataTypesListCell"
}

class DataTypesTableViewController: UITableViewController, DataTypesUseCase {
     var cellNames = [Int]()
    
    func hideActivityIndicator() {
        print("hide")
    }
    
    func set(data: [MonthWithProperties]) {
        
        monthList = data
        print(data)
        let years = data.map() {$0.year}
        cellNames =  Array(Set(years)).sorted()
        tableView.reloadData()
    }
    
    var output: DataTypesEventHandler!
    var monthList: [MonthWithProperties]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.fetchWeatherData()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        navigationController?.navigationBar.topItem?.title = DataTypesList.navigationBarTitleText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: DataTypesList.reuseId)
        cell.textLabel?.text = String(cellNames[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.navigator.pushChart(values: monthList, year: cellNames[indexPath.row])
    }
}
