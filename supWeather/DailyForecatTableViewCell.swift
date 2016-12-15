//
//  DailyForecatTableViewCell.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import UIKit

class DailyForecatTableViewCell: UITableViewCell {
    static let identifier = "DailyForecatTableViewCell"
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperatureMax: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var temperatureMin: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
