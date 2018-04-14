//
//  SplashViewController.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit
import CoreLocation

class SplashViewController: BaseViewController {

    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.Coffee.background
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestWhenInUseAuthorization()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - private functions
    private func checkAuthoizationStatus(_ status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("not determined")
            requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
            UIAlertController.alert(text: "Unable to access your location. Please allow your location to continue at Settings app.") {
                self.requestWhenInUseAuthorization()
            }
        case .denied:
            print("denined")
            UIAlertController.alert(text: "Unable to access your location. Please allow your location to continue at Settings app.") {
                self.requestWhenInUseAuthorization()
            }
        case .authorizedAlways:
            print("authoized always")
            moveToLocationList()
        case .authorizedWhenInUse:
            print("authoized when is use")
            moveToLocationList()
        }
    }
    private func animateLogo(completion: @escaping (() -> Void)) {
        //TODO: implement an animation later...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            completion()
        }
    }
    private func moveToLocationList() {
        animateLogo {
            self.navigationController?.pushViewController(CoffeeShopListViewController(), animated: true)
        }
    }
    private func requestWhenInUseAuthorization() {
        LocationManager.shared.requestWhenInUseAuthorization({ (status) in
            self.checkAuthoizationStatus(status)
        })
    }
}
