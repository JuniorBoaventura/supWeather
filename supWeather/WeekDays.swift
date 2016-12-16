//
//  WeekDays.swift
//  supWeather
//
//  Created by Junior Boaventura on 16.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Foundation

enum WeekDays: Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
    
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