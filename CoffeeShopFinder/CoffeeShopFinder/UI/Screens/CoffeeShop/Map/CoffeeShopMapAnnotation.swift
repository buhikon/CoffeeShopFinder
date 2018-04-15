//
//  CoffeeShopMapAnnotation.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import MapKit

class CoffeeShopMapAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(coffeeShop: CoffeeShop) {
        self.title = coffeeShop.name
        self.subtitle = coffeeShop.address
        self.coordinate = CLLocationCoordinate2D(latitude: coffeeShop.latitude ?? 0.0, longitude: coffeeShop.longitude ?? 0.0)
        super.init()
    }
}

