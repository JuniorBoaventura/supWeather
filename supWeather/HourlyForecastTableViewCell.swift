//
//  HourlyForecastTableViewCell.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {
    
    static let identifier = "HourlyForecastTableViewCell"

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    lazy var formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    var hourly: [Forecast]! {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        let nib = R.nib.hourlyForecastCollectionViewCell()
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
    }

}

extension HourlyForecastTableViewCell: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! HourlyForecastCollectionViewCell
        let prevision = self.hourly[indexPath.row]
        
        cell.image.image = prevision.type?.icon
        cell.title.text = self.formatter.stringFromDate(prevision.date) + "h"
        cell.temperature.text = prevision.temperature
    }
    
}

extension HourlyForecastTableViewCell: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hourly.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HourlyForecastCollectionViewCell.identifier, forIndexPath: indexPath) as! HourlyForecastCollectionViewCell
        return cell
    }
    
}
