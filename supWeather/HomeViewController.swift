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
        let width = self.view.bounds.width - 160
        self.view.layer.addSublayer(self.gradient)
        self.view.bringSubviewToFront(self.footerView)
        itemSize = CGSize(width: width, height: width * 1.3)
        super.viewDidLoad()
        
        
        let forecastNib = R.nib.forecastCollectionViewCell()
        self.collectionView?.registerNib(forecastNib, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        
        // Fetch the forecast
        self.fetchForecast()
        
        
        if self.collectionView != nil {
            self.addGestureToView(collectionView!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchForecast() {
        if Reachability.isConnectedToNetwork() == true {
            
            let city = R.image.city()
            self.forecastOperation("New York", coordinates: (lat: 40.712784, long: -74.005941), image: city)
        
            let desert = R.image.desert()
            self.forecastOperation("Las Vegas", coordinates: (lat: 36.169941, long: -115.139830), image: desert)
        
            let lake = R.image.lake()
            self.forecastOperation("Minnetonka", coordinates: (lat: 44.918196, long: -93.463633), image: lake)
        
            let moutains = R.image.moutains()
            self.forecastOperation("Neuchâtel", coordinates: (lat: 46.988138, long: -6.939626), image: moutains)
        
        
            let operation = LocationOperation { (location, place) in
                self.forecastOperation(place, coordinates: location, image: city)
            }
        
            self.operationQueue.addOperation(operation)
        } else {
            
            let error = "Make sure your device is connected to the internet."
            let noConnection = UIAlertController(title: "No Internet Connection", message: error, preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "Yes", style: .Default) { (action) -> Void in
               
            }
            
            noConnection.addAction(okAction)
            self.presentViewController(noConnection, animated: true, completion: nil)
        }
    }
    
    func forecastOperation(place: String, coordinates: Coordinates, image: UIImage?) {
        
        
        let request = APIRouter.getForecast(coordinates)
        
        let getForecast = NetworkOperation(request: request) { (apiResult) in
            
            if let json = apiResult.data {
                var place = Place(name: place, coordinates: coordinates, result: json)
                place.image = image
                self.forecast.insert(place, atIndex: 0)
                self.cellsIsOpen.append(false)
                self.collectionView?.reloadData()
            }
            
        }
        
        self.operationQueue.addOperation(getForecast)
    }
    

    @IBAction func refresh(sender: AnyObject) {
        self.cellsIsOpen.removeAll()
        self.forecast.removeAll()
        self.fetchForecast()
    }

}


extension HomeViewController {
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        super.collectionView(collectionView, willDisplayCell: cell, forItemAtIndexPath: indexPath)
        let cell  = cell as! ForecastCollectionViewCell
        let place = self.forecast[indexPath.row]
        cell.forecast = place
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
            cell.cellIsOpen(true)
        } else {
            self.displayForecastSummary(indexPath)
        }
        
    }
    
    func displayForecastSummary(indexPath:NSIndexPath) {
        let vc = R.storyboard.main.forecastSummaryTableViewController()!
        vc.forecast = self.forecast[indexPath.row]
        vc.navigationItem.hidesBackButton = true
        pushToViewController(vc)
    }

}

extension HomeViewController {
    
    func addGestureToView(toView: UIView) {
        
        let gesutereUp = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.swipeHandler(_:)))
        gesutereUp.direction = .Up
        
        
        let gesutereDown = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.swipeHandler(_:)))
        gesutereDown.direction = .Down
        
        toView.addGestureRecognizer(gesutereUp)
        toView.addGestureRecognizer(gesutereDown)
    }
    
    func swipeHandler(sender: UISwipeGestureRecognizer) {
        
        let indexPath = NSIndexPath(forItem: currentIndex, inSection: 0)
        guard let cell  = self.collectionView?.cellForItemAtIndexPath(indexPath) as? ForecastCollectionViewCell else { return }
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .Up {
             self.displayForecastSummary(indexPath)
        }
        
        let open = sender.direction == .Up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }
}




