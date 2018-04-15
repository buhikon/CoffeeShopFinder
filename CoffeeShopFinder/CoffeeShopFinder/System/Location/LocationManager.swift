//
//  LocationManager.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    // Singleton
    static let shared = LocationManager()
    
    // defines
    typealias AuthorizationHandler = (CLAuthorizationStatus) -> Void
    typealias LocationHandler = (CLLocation?, Error?) -> Void
    static var NotificationAuthorizationChange = NSNotification.Name(rawValue: "NotificationAuthorizationChange")
    
    // variables
    var locationManager = CLLocationManager()
    var authorizationHandler: AuthorizationHandler? = nil
    var locationHandler: LocationHandler? = nil
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    // MARK: - public functions
    public func requestWhenInUseAuthorization(_ handler: @escaping AuthorizationHandler) {
        let status = authorizationStatus()
        if status == .notDetermined {
            authorizationHandler = handler
            locationManager.requestWhenInUseAuthorization()
        }
        else {
            handler(status)
        }
    }
    public func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    public var isGranted: Bool {
        let status = authorizationStatus()
        return (status == .authorizedWhenInUse || status == .authorizedAlways)
    }
    public func getUserLocation(_ handler: @escaping LocationHandler) {
        locationHandler = handler
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        //TODO: clean up this code after testing
        switch status {
        case .notDetermined:
            print("location autorization: not determined")
        case .restricted:
            print("location autorization: restricted")
        case .denied:
            print("location autorization: denined")
        case .authorizedAlways:
            print("location autorization: authoized always")
        case .authorizedWhenInUse:
            print("location autorization: authoized when is use")
        }
        
        if status != .notDetermined {
            if let handler = authorizationHandler {
                handler(status)
                authorizationHandler = nil
            }
        }
        
        // post notification
        let granted = (status == .authorizedWhenInUse || status == .authorizedAlways)
        NotificationCenter.default.post(name: LocationManager.NotificationAuthorizationChange,
                                        object: self,
                                        userInfo: ["granted":granted])
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let eventDate = location.timestamp
            let howRecent = eventDate.timeIntervalSinceNow
            if (fabs(howRecent) < 15.0) {
                manager.stopUpdatingLocation()
                
                if let handler = locationHandler {
                    handler(location, nil)
                    locationHandler = nil
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        
        if let handler = locationHandler {
            handler(nil, error)
            locationHandler = nil
        }
    }
}
