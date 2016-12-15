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
    var coordinates:Coordinates!
    var currently: Forecast!
    var hourly = [Forecast]()
    
    init(name: String, coordinates: Coordinates, result:JSON) {
        self.name = name
        self.coordinates = coordinates
        
        if let currently = result["currently"].dictionaryObject {
            self.currently = Forecast(data: currently)
        }
        
        if let data = result["hourly"]["data"].array {
            data.forEach({ (item) in
                if let hour = item.dictionaryObject {
                    self.hourly.append(Forecast(data: hour))
                }
            })
        }
        
    }
}