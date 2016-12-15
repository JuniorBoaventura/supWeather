//
//  APIRouter.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.11.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Foundation
import Alamofire


typealias Coordinates = (lat:Float, long: Float)

enum APIRouter {
    
    case getForecast(Coordinates)
    
    var endpoint: String {
        switch self {
        case let .getForecast(coordinates):
            return "forecast/\(DarkSky.apiKey)/\(coordinates.lat),\(coordinates.long)?units=si"
        }
    }
    
    
    var path: String {
        switch self {
        case .getForecast:
            return DarkSky.baseUrl + self.endpoint
        }
        
    }
    
    var method: Alamofire.Method {
        switch self {
        case.getForecast:
            return .GET
        }

    }
    
    var encoding: Alamofire.ParameterEncoding {
        switch self.method {
        case .POST, .PATCH, .PUT:
            return .JSON
        case .GET:
            return .URL
        default:
            return .JSON
        }
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var headers: [String:String]? {
        return nil
    }

}
