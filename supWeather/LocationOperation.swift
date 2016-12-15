//
//  LocationOperation.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import UIKit
import Operations
import CoreLocation

typealias LocationGeocodingCompletion = ((location: Coordinates, place: String) -> Void)

class LocationOperation: Operation {
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    let completion: LocationGeocodingCompletion!
    
    init(completion: LocationGeocodingCompletion) {
        
        // Ask for user authorization
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.distanceFilter = 1000
        self.completion = completion
        super.init()
    }
    
    override func execute() {
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    func reverseGeocoing(location: CLLocation) {
        let geoCoder = CLGeocoder()
    

        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            if let pm = placemarks where pm.count > 0 {
                
                let coordinates = (lat: Float(location.coordinate.latitude), long: Float(location.coordinate.longitude))
                let place = pm[0].locality!
                self.completion(location: coordinates, place: place)
            }
            
            
        })
    }
}

extension LocationOperation: CLLocationManagerDelegate {
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        
        self.reverseGeocoing(CLLocation(latitude: location.latitude, longitude: location.longitude))
        self.locationManager.stopUpdatingLocation()
        print("locations = \(location.latitude) \(location.longitude)")
    }
}


