//
//  WeatherType.swift
//  supWeather
//
//  Created by Junior Boaventura on 16.12.16.
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
            return "Thunderstorm"
        default:
            return nil
        }
    }
}

