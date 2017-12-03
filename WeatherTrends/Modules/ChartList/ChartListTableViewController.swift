//
//  ChartListTableViewController.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 12/1/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import UIKit

enum ChartListCell {
    static let reuseId = "cell"
    static let numberOfSections = 1
    static let heightForRow: CGFloat = 200.0
}

final class ChartListTableViewController: UITableViewController {
    var monthsList: [MonthWithProperties]!
    private var categiries = [ChartType.tMax, ChartType.tMin]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
}

private extension ChartListTableViewController {
    func setupTableView() {
        tableView.register(ChartListTableViewCell.self, forCellReuseIdentifier: ChartListCell.reuseId)
        tableView.allowsSelection = false
        navigationItem.title = String(describing: monthsList.first?.year ?? 0)
    }
}

extension ChartListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ChartListCell.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categiries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartListCell.reuseId, for: indexPath) as! ChartListTableViewCell
        if cell.contentViewController == nil {
            cell.addViewController(toParentViewController: self, values: monthsList, chartType: categiries[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ChartListCell.heightForRow
    }
}
