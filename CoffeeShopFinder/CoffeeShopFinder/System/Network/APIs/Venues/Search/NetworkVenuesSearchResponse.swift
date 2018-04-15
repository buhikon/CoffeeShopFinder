//
//  NetworkVenuesSearchResponse.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import ObjectMapper

class NetworkVenuesSearchResponse: NetworkResponse {
    
    var response: Response?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        response <- map["response"]
    }
    
    
    // $.response
    class Response: Mappable {
        var venues: [Venues]?
        
        required init?(map: Map) {}
        func mapping(map: Map) {
            venues <- map["venues"]
        }
        
        // $.response.venues[*]
        class Venues: Mappable {
            var id: String?
            var name: String?
            var contact: Contact?
            var location: Location?
            
            required init?(map: Map) {}
            func mapping(map: Map) {
                id <- map["id"]
                name <- map["name"]
                contact <- map["contact"]
                location <- map["location"]
            }
            
            // $.response.venues[*].contact
            class Contact: Mappable {
                var phone: String?
                var formattedPhone: String?
                var twitter: String?
                var facebook: String?
                var facebookUsername: String?
                var facebookName: String?
                
                required init?(map: Map) {}
                func mapping(map: Map) {
                    phone <- map["phone"]
                    formattedPhone <- map["formattedPhone"]
                    twitter <- map["twitter"]
                    facebook <- map["facebook"]
                    facebookUsername <- map["facebookUsername"]
                    facebookName <- map["facebookName"]
                }
            }
            
            // $.response.venues[*].location
            class Location: Mappable {
                var address: String?
                var crossStreet: String?
                var lat: Double?
                var lng: Double?
                var distance: Int?
                var postalCode: String?
                var cc: String?
                var city: String?
                var state: String?
                var country: String?
                
                required init?(map: Map) {}
                func mapping(map: Map) {
                    address <- map["address"]
                    crossStreet <- map["crossStreet"]
                    lat <- map["lat"]
                    lng <- map["lng"]
                    distance <- map["distance"]
                    postalCode <- map["postalCode"]
                    cc <- map["cc"]
                    city <- map["city"]
                    state <- map["state"]
                    country <- map["country"]
                }
            }
            
        }
    }
}

