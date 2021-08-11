//
//  DetailWeatherTableViewController.swift
//  SB-HW2.10 (Api)
//
//  Created by Vladislav Kulak on 11.08.2021.
//

import UIKit

class DetailWeatherTableViewController: UITableViewController {
    
    var forecasts: [Forecast]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecasts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailWeatherTableViewCell

        let forecast = forecasts[indexPath.row]
        cell.configure(with: forecast)

        return cell
    }

}
