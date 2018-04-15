//
//  UIAlertController+Simple.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 14/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

extension UIAlertController {
    /// show alertview
    ///
    /// - Parameters:
    ///   - text: text to show in alertview
    ///   - completion: this will be called when *OK* button tapped
    class func alert(text: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                if let completion = completion {
                    completion()
                }
            }))
            Helper.viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
