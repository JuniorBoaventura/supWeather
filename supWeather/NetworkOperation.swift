//
//  PostSellerOperation.swift
//  Gookers
//
//  Created by Junior Boaventura on 25.07.16.
//  Copyright © 2016 Gookers. All rights reserved.
//

import UIKit
import Operations
import Alamofire
import SwiftyJSON

typealias APIManagerCompletion = ((apiResult: APIResult) -> Void)

@objc(NetworkOperation)
class NetworkOperation: Operation {
    var request: APIRouter!
    var networkCompletion: APIManagerCompletion?
    
    var result:APIResult = APIResult()

    required init(request: APIRouter, withcompletion completion: APIManagerCompletion?) {
        super.init()
        self.request = request
        self.networkCompletion = completion
        self.name = String(request)
    }
    
    override func execute() {
       // #if DEBUG
        print(self.request.parameters)
       // #endif
        HTTPManager.sharedManager.request(self.request.method, self.request.path, parameters: self.request.parameters, encoding: self.request.encoding, headers: self.request.headers)
        .validate()
        .responseJSON { (response) in

            if response.result.isFailure == true {
                self.cancel()
            }
            
            if let data =  response.data, let code = response.response?.statusCode {
                let json = JSON(data:data)
                self.result.data = json
                self.result.statusCode = code
                
                if let completion = self.networkCompletion  {
                    completion(apiResult: self.result)
                }
            }
            self.finish()
        }
    }

}
