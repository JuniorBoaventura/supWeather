//
//  ParseForecastOperation.swift
//  supWeather
//
//  Created by Junior Boaventura on 06.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Operations
import SwiftyJSON

class ParseForecastOperation: Operation {
    var data:JSON!
    var place: String!
    var coordinates: Coordinates!
    
    required init(name:String, coordinates:Coordinates, result:APIResult) {
        super.init()
        
        self.data = result.data
        self.place = name
        self.coordinates = coordinates
    }
    
    override func execute() {
        
    }
}
