//
//  DetailWeatherTableViewCell.swift
//  SB-HW2.10 (Api)
//
//  Created by Vladislav Kulak on 11.08.2021.
//

import UIKit

class DetailWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    
    // MARK: - Public methods
    func configure(with forecast: Forecast?) {
        dateLabel.text = forecast?.date
        sunriseLabel.text = forecast?.sunrise
        sunsetLabel.text = forecast?.sunset
    }

}
