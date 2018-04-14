//
//  Font.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//
//  Default iOS fonts can be found below web page:
//  http://iosfonts.com/

import UIKit

extension UIFont {
    
    static func bold(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "KohinoorDevanagari-Medium", size: fontSize)!
    }
    static func light(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "KohinoorDevanagari-Light", size: fontSize)!
    }
}
