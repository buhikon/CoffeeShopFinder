//
//  SplashPresenter.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 14/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import CoreLocation

protocol SplashView : NSObjectProtocol {
    /// show UIAlertController
    ///
    /// - Parameters:
    ///   - text: text to show in alertview
    ///   - completion: handler of *OK* button in alertview
    func alert(text: String, completion: (() -> Void)?)
    /// move to *CoffeeShopListViewController*
    func moveToCoffeeShopList()
}

class SplashPresenter: BasePresenter {
    weak var view: SplashView?
    
    // MARK: - internal functions
    
    /// check whether or not location authorization is granted.
    func requestWhenInUseAuthorization() {
        LocationManager.shared.requestWhenInUseAuthorization({ (status) in
            self.checkAuthoizationStatus(status)
        })
    }
    
    // MARK: - private functions
    
    /// check authorization status and do next process
    ///
    /// - Parameter status: CLAuthorizationStatus
    private func checkAuthoizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("not determined")
            requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
            view?.alert(text: "This app cannot access your location. Please allow your location to continue at Settings app.") {
                self.requestWhenInUseAuthorization()
            }
        case .denied:
            print("denined")
            view?.alert(text: "This app cannot access your location. Please allow your location to continue at Settings app.") {
                self.requestWhenInUseAuthorization()
            }
        case .authorizedAlways:
            print("authoized always")
            view?.moveToCoffeeShopList()
        case .authorizedWhenInUse:
            print("authoized when is use")
            view?.moveToCoffeeShopList()
        }
    }
}

