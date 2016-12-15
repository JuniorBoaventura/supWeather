//
//  ViewController.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.11.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import UIKit
import Operations
import expanding_collection
import DynamicColor

class HomeViewController: ExpandingViewController {
    
    @IBOutlet weak var footerView: UIView!

    var cellsIsOpen = [Bool]()
    let operationQueue = OperationQueue()
    
    let color1   = UIColor(hex: 0xdfecfc)
    let color2    = UIColor(hex: 0xb9d6f8)
    
    lazy var gradient:CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0 , 1.1]
        gradient.frame = self.view.frame
        gradient.colors = [self.color1.CGColor, self.color2.CGColor]
        return gradient
    }()
    
    var forecast = [Place]()

    override func viewDidLoad() {
        
        
        
        self.view.backgroundColor = UIColor.clearColor()
        let width = self.view.bounds.width - 100
        self.view.layer.addSublayer(self.gradient)
        self.view.bringSubviewToFront(self.footerView)
        itemSize = CGSize(width: width, height: width * 1.3)
        super.viewDidLoad()
        
        
        let forecastNib = R.nib.forecastCollectionViewCell()
        self.collectionView?.registerNib(forecastNib, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        
        let coordinates:Coordinates = (lat: 48.8566, long: 2.3522)
        let request = APIRouter.getForecast(coordinates)
        
        let getForecast = NetworkOperation(request: request) { (apiResult) in
            
            if let json = apiResult.data {
                let place = Place(name: "Paris", coordinates: coordinates, result: json)
                self.forecast.append(place)
                self.collectionView?.reloadData()
            }
            
        }
        
        self.operationQueue.addOperation(getForecast)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension HomeViewController {
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        super.collectionView(collectionView, willDisplayCell: cell, forItemAtIndexPath: indexPath)
        let cell  = cell as! ForecastCollectionViewCell
        let place = self.forecast[indexPath.row]
        cell.forecast = place
        cell.temperature.text = place.currently.temperature
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.forecast.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ForecastCollectionViewCell.identifier, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ForecastCollectionViewCell
            where currentIndex == (indexPath as NSIndexPath).row else { return }
        
        if cell.isOpened == false {
//            cell.collectionView.becomeFirstResponder()
            cell.cellIsOpen(true)
        } else {
            let vc = R.storyboard.main.forecastSummaryTableViewController()!
            vc.forecast = self.forecast[indexPath.row]
            vc.navigationItem.hidesBackButton = true
            pushToViewController(vc)
        }
        
        
        
        
    }
}



