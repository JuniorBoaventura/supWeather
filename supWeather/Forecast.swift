//
//  Forecast.swift
//  supWeather
//
//  Created by Junior Boaventura on 06.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Foundation


struct Forecast {
    private var __temperature:Float!
    internal var temperature:String? {
        return String(format: "%.0f", self.__temperature) + "°"
    }
    
    private var __temperatureMax:Float!
    internal var temperatureMax:String? {
        return String(format: "%.0f", self.__temperatureMax) + "°"
    }
    
    private var __temperatureMin:Float!
    internal var temperatureMin:String? {
        return String(format: "%.0f", self.__temperatureMin) + "°"
    }
    
    private var __humidity: Float!
    internal var humidity: String! {
        return String(__humidity)
    }

    var summary: String?
    var date: NSDate!
    var type: WeatherType?
    
    var dayOfWeek: WeekDays {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let weekDay = calendar.components(.Weekday, fromDate: self.date).weekday
        return WeekDays(rawValue: weekDay)!
    }
    
    init(data:[String:AnyObject]) {
        
        if let temperature = data["temperature"] as? Float {
            self.__temperature = temperature
        }
        
        if let temperatureMin = data["temperatureMin"] as? Float {
            self.__temperatureMin = temperatureMin
        }
        
        if let temperatureMax = data["temperatureMax"] as? Float {
            self.__temperatureMax = temperatureMax
        }
        
        if let humidity = data["humidity"] as? Float {
            self.__humidity = humidity
        }
        
        if let summary = data["summary"] as? String {
            self.summary = summary
        }
        
        if let time = data["time"] as? Double {
            self.date = NSDate.init(timeIntervalSince1970: time)
        }
        
        if let _icon = data["icon"] as? String, let type = WeatherType(rawValue: _icon) {
            self.type = type
        }
        
    }
    

}
