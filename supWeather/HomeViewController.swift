//
//  ViewController.swift
//  supWeather
//
//  Created by Junior Boaventura on 15.11.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import UIKit
import Operations

class HomeViewController: UIViewController {
    
    let operationQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = APIRouter.getForecast((lat: 48.8566, long: 2.3522))
        
        let getForecast = NetworkOperation(request: request) { (apiResult) in
            print(apiResult.data)
        }
        
        self.operationQueue.addOperation(getForecast)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

