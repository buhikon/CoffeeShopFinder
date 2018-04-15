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
    static var NotificationAuthorizationChange = NSNotification.Name(rawValue: "NotificationAuthorizationChange")
    typealias AuthorizationHandler = (CLAuthorizationStatus) -> Void
    typealias LocationHandler = (CLLocation?, Error?) -> Void
    
    // variables
    private var locationManager = CLLocationManager()
    private var authorizationHandler: AuthorizationHandler? = nil
    private var locationHandler: LocationHandler? = nil
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    // MARK: - public functions
    
    /// check whether or not location authorization is granted.
    /// - discussion: if it is not determined, the system will show alertview and ask to user.
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
    
    /// check current authorization status
    ///
    /// - Returns: authoization status
    public func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    /// check current authoization status is granted or not
    /// this will be true if status is *.authorizedWhenInUse* or *.authorizedWhenInUse*.
    public var isGranted: Bool {
        let status = authorizationStatus()
        return (status == .authorizedWhenInUse || status == .authorizedAlways)
    }
    /// get user location
    ///
    /// - Parameter handler: user location can be found in CLLocation
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
