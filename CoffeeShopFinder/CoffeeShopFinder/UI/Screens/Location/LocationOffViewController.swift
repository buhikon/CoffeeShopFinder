//
//  LocationOffViewController.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

class LocationOffViewController: BaseViewController {

    override func loadView() {
        super.loadView()
        
        // create and set UI
        let label = UILabel(frame: mainView.bounds)
        label.font = UIFont.bold(30.0)
        label.textColor = UIColor.Coffee.dark
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Location Service is off\nPlease go to Settings app to turn on"
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.addSubview(label)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
