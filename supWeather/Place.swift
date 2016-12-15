//
//  Place.swift
//  supWeather
//
//  Created by Junior Boaventura on 06.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Place {
    var name: String!
    var image: UIImage?
    
    var coordinates:Coordinates!
    var currently: Forecast!
    
    var hourly = [Forecast]()
    var daily  = [Forecast]()
    
    init(name: String, coordinates: Coordinates, result:JSON) {
        self.name = name
        self.coordinates = coordinates
        
        if let currently = result["currently"].dictionaryObject {
            self.currently = Forecast(data: currently)
        }
        
        if let houlryData = result["hourly"]["data"].array {
            houlryData.forEach({ (item) in
                if let hour = item.dictionaryObject {
                    self.hourly.append(Forecast(data: hour))
                }
            })
        }
        
        if let dailyData = result["daily"]["data"].array {
            dailyData.forEach({ (item) in
                if let hour = item.dictionaryObject {
                    self.daily.append(Forecast(data: hour))
                }
            })
        }
        
    }
}