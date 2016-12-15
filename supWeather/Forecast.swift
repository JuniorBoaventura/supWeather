//
//  Forecast.swift
//  supWeather
//
//  Created by Junior Boaventura on 06.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Foundation
import UIKit


enum WeatherType: String {
    case clearDay   = "clear-day"
    case clearNight = "clear-night"
    case rain       = "rain"
    case snow       = "snow"
    case sleet      = "sleet"
    case wind       = "wind"
    case fog        = "fog"
    case cloudy     = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case thunderstorm = "thunderstorm"
    case tornado    = "tornado"
    
    var icon: UIImage? {
        switch self {
        case .clearDay:
            return R.image.icClearDay()
        case .clearNight:
            return R.image.icMoon()
        case .rain:
            return R.image.icRain()
        case .snow:
            return R.image.icSnow()
        case .wind:
            return R.image.icWind()
        case .cloudy, partlyCloudyDay, .partlyCloudyNight:
            return R.image.icCloudy()
        case .thunderstorm:
            return R.image.icThunderstorm()
        default:
            return nil
        }
    }
    
    var summary: String? {
        switch self {
        case .clearDay:
            return "Sunny"
        case .rain:
            return "Rain"
        case .snow:
            return "Snow"
        case .wind:
            return "Windy"
        case .cloudy, partlyCloudyDay, .partlyCloudyNight:
            return "Cloudy"
        case .thunderstorm:
            return "thunderstorm"
        default:
            return nil
        }
    }
}

enum WeekDay: Int{
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
    case Sunday = 7
    
    var name: String {
        switch self {
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        case .Sunday:
            return "Sunday"
        }
    }
}


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
    
    var dayOfWeek: WeekDay {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let weekDay = calendar.components(.Weekday, fromDate: self.date).weekday
        return WeekDay(rawValue: weekDay)!
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
