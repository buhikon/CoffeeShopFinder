//
//  SplashPresenter.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 14/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import CoreLocation

protocol SplashView : NSObjectProtocol {
    func alert(text: String, completion: (() -> Void)?)
    func moveToLocationList()
}

class SplashPresenter: BasePresenter {
    weak var view: SplashView?
    
    // MARK: - internal functions
    func requestWhenInUseAuthorization() {
        LocationManager.shared.requestWhenInUseAuthorization({ (status) in
            self.checkAuthoizationStatus(status)
        })
    }
    
    // MARK: - private functions
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
            view?.moveToLocationList()
        case .authorizedWhenInUse:
            print("authoized when is use")
            view?.moveToLocationList()
        }
    }
}

