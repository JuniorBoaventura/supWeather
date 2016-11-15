//
//  GooAPIResultContext.swift
//  Gookers
//
//  Created by Brossard Pierre on 11.05.16.
//  Copyright © 2016 Gookers. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIResult: AnyObject {
    var data: JSON?

    var statusCode: Int?
    
    init(data sData: JSON?) {
        self.data = sData
    }
    
        
    init(){}
}
