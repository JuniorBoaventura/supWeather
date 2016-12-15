//
//  TransparentNavigationController.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import Foundation
import UIKit

class TransparentNavigationBar: UINavigationBar {
    override func drawRect(rect: CGRect) {
        self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.shadowImage = UIImage()
        self.translucent = true
    }
}
