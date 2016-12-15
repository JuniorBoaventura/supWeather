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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var temperature: UILabel!
    
    var forecast: Place? {
        didSet {
            self.place.text = forecast?.name
            self.collectionView.reloadData()
        }
    }
    
    static let identifier = "ForecastCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = R.nib.hourlyForecastCollectionViewCell()
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 50, height: 50)
    }

}

extension ForecastCollectionViewCell: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! HourlyForecastCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
    }

}

extension ForecastCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.forecast?.hourly.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HourlyForecastCollectionViewCell.identifier, forIndexPath: indexPath) as! HourlyForecastCollectionViewCell
        return cell
    }
    
}
