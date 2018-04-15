//
//  NetworkResponse.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import ObjectMapper

class NetworkResponse: Mappable {
    
    var meta: Meta?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        meta <- map["meta"]
    }
    
    // $.meta
    class Meta: Mappable {
        var code: Int?
        var requestId: String?
        
        required init?(map: Map) {}
        func mapping(map: Map) {
            code <- map["code"]
            requestId <- map["requestId"]
        }
    }
}



