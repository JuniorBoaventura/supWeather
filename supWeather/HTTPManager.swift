//
//  HTTPManager.swift
//  Gookers
//
//  Created by Brossard Pierre on 04.07.16.
//  Copyright © 2016 Gookers. All rights reserved.
//

import UIKit
import Alamofire
import Timberjack

class HTTPManager: Alamofire.Manager {
    static let sharedManager: HTTPManager = {
        let configuration = Timberjack.defaultSessionConfiguration()
        let manager = HTTPManager(configuration: configuration)
        return manager
    }()
}
