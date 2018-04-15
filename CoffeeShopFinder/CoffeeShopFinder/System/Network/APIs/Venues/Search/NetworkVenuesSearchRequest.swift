//
//  NetworkVenuesSearchRequest.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//
//  API document:
//  https://developer.foursquare.com/docs/api/venues/search
//
//  * only some of parameters are defined in this class. 

import UIKit

import Foundation

class NetworkVenuesSearchRequest: NetworkRequest {
    
    var latitude: Double? = nil
    var longitude: Double? = nil
    var intent: String? = nil
    var categoryId: String? = nil
    var radius: Int? = nil
    var limit: Int? = nil
    
    init(latitude: Double, longitude: Double, intent: String, categoryId: String, radius: Int, limit: Int) {
        super.init()
        self.path = "/venues/search"
        self.latitude = latitude
        self.longitude = longitude
        self.intent = intent
        self.categoryId = categoryId
        self.radius = radius
        self.limit = limit
        
        addToJsonData()
    }
    
    class func coffeeShop(latitude: Double, longitude: Double) -> NetworkVenuesSearchRequest {
        return NetworkVenuesSearchRequest(latitude: latitude,
                                          longitude: longitude,
                                          intent: "checkin",
                                          categoryId: "4bf58dd8d48988d1e0931735",
                                          radius: 5000,
                                          limit: 50)
    }
    
    // MARK: - private functions
    private func addToJsonData() {
        if let latitude = latitude, let longitude = longitude {
            jsonData["ll"] = "\(latitude),\(longitude)"
        }
        if let intent = intent {
            jsonData["intent"] = intent
        }
        if let categoryId = categoryId {
            jsonData["categoryId"] = categoryId
        }
        if let radius = radius {
            jsonData["radius"] = radius
        }
        if let limit = limit {
            jsonData["limit"] = limit
        }
    }
}

