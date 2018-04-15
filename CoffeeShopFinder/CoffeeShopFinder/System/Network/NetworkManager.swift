//
//  NetworkManager.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    @discardableResult
    public class func request(_ request: NetworkRequest) -> DataRequest {
        return Alamofire.request(request.urlRequest!)
    }
}
