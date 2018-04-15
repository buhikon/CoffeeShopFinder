//
//  Helper.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 14/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

class Helper {
    class var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    class var window: UIWindow {
        return appDelegate.window!
    }
    class var viewController: UIViewController {
        return window.rootViewController!
    }
}
