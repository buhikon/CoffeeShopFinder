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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
