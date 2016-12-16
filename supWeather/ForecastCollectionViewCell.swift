//
//  ForecastCollectionViewCell.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.11.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import UIKit
import expanding_collection

class ForecastCollectionViewCell: BasePageCollectionCell {
    
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var summary: UILabel!
    
    var forecast: Place? {
        didSet {
            self.place.text = forecast?.name
            self.temperature.text = forecast?.currently.temperature
            self.background.image = forecast?.image
            self.summary.text = forecast?.currently.summary
        }
    }
    
    static let identifier = "ForecastCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
