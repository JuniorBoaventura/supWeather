//
//  DarkSky.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.11.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Foundation

struct DarkSky {
    
    static var apiKey: String {
        let filePath = NSBundle.mainBundle().pathForResource("DarkSky", ofType: "plist")
        let plist    = NSDictionary(contentsOfFile:filePath!)
        return plist?.valueForKey("apiKey") as! String
    }
    
    static let baseUrl = "https://api.darksky.net/"
}