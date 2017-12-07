//
//  DataTypesTableViewController.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

enum DataTypesList {
    static let navigationBarTitleText = "Years"
    static let reuseId = "DataTypesListCell"
    static let errorHint = "You probably have to start local server from github repo"
}

final class DataTypesTableViewController: UITableViewController, DataTypesUseCase {
    var output: DataTypesEventHandler!
    private var cellNames = [Int]()
    private var monthList: [MonthWithProperties]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}

private extension DataTypesTableViewController {
    func setupTableView() {
        FullScreenActivityPresenter.shared.showActivityIndicator(forViewController: self)
        output.fetchWeatherData()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        navigationController?.navigationBar.topItem?.title = DataTypesList.navigationBarTitleText
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension DataTypesTableViewController {
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

extension DataTypesTableViewController {
    func hideActivityIndicator() {
        FullScreenActivityPresenter.shared.hideActivityIndicator(forViewController: self)
    }
    
    func set(data: [MonthWithProperties]) {
        monthList = data
        let years = data.map() { $0.year }
        cellNames =  Array(Set(years)).sorted()
        tableView.reloadData()
    }
    
    func showError(error: CAError) {
        let alertViewController = UIAlertController(title: error.localizedDescription, message: DataTypesList.errorHint, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
