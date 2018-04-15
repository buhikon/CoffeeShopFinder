//
//  Color.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//
//  # Usage :
//    UIColor.Coffee.light
//    UIColor.Coffee.background

import UIKit

extension UIColor {
    struct Coffee {
        static var dark: UIColor { return UIColor(red: 70.0/255.0, green: 40.0/255.0, blue: 16.0/255.0, alpha: 1) }
        static var light: UIColor { return UIColor(red: 221.0/255.0, green: 144.0/255.0, blue: 74.0/255.0, alpha: 1) }
        static var background: UIColor { return UIColor(red: 86.0/255.0, green: 55.0/255.0, blue: 34.0/255.0, alpha: 1) }
    }
}
