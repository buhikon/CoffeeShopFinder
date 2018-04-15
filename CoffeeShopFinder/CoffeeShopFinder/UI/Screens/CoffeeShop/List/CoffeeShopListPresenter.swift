//
//  CoffeeShopListPresenter.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import CoreLocation
import Alamofire
import AlamofireObjectMapper

protocol CoffeeShopListView: NSObjectProtocol {
    /// set CoffeeShop list to view
    ///
    /// - Parameter coffeeShops: array of CoffeeShop object
    func setCoffeeShopList(_ coffeeShops: [CoffeeShop])
    /// notify to view that present *LocationOffViewController* if not presented
    func presentLocationOffViewController()
    /// notify to view that dismiss *LocationOffViewController* if not dismissed
    func dismissLocationOffViewController()
    /// show loading indicator on header
    func showLoadingOnHeaderView()
    /// hide loading indicator on header, and reset timer with argument interval.
    ///
    /// - Parameter interval: interval for reset timer
    func hideLoadingAndStartTimerOnHeaderView(interval: TimeInterval)
    /// make toast message on the bottom of screen, like Android.
    ///
    /// - Parameter text: text to show in toast
    func makeToast(_ text: String?)
}

class CoffeeShopListPresenter: BasePresenter {
    weak var view: CoffeeShopListView?
    
    // MARK: - internal functions
    
    /// check current location authorization, and present or dismiss *LocationOffViewController*
    func checkLocationAuthorization() {
        if LocationManager.shared.isGranted == false {
            view?.presentLocationOffViewController()
        }
        else {
            view?.dismissLocationOffViewController()
        }
    }
    
    /// reload CoffeeShop list
    ///   1. get user location
    ///   2. request coffee shop list to FourSquare server based on the user location
    ///   3. create array of CoffeeShop
    ///   4. deliver it to view
    func reloadData() {
        view?.showLoadingOnHeaderView()
        LocationManager.shared.getUserLocation { (location, error) in
            if let location = location {
                self.requestCoffeeShopList(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: { (errorMessage) in
                    if errorMessage == nil {
                        // suceess
                        self.view?.hideLoadingAndStartTimerOnHeaderView(interval: 30.0)
                    }
                    else {
                        // failed while network to server
                        self.view?.hideLoadingAndStartTimerOnHeaderView(interval: 10.0)
                        self.view?.makeToast(errorMessage)
                    }
                })
            }
            else {
                // failed to get user's current location
                self.view?.hideLoadingAndStartTimerOnHeaderView(interval: 10.0)
                self.view?.makeToast("Failed to get current location.")
            }
        }
    }
    
    // MARK: - private functions
    
    /// request coffee shop list to FourSquare server.
    /// and create an array of CoffeeShop object.
    ///
    /// - Parameters:
    ///   - latitude: latitude of user location
    ///   - longitude: longitude of user location
    ///   - completion: completion handler
    private func requestCoffeeShopList(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let request = NetworkVenuesSearchRequest.coffeeShop(latitude: latitude, longitude: longitude)
        NetworkManager.request(request).responseObject { (response: DataResponse<NetworkVenuesSearchResponse>) in
            if response.result.isSuccess {
                if let data = response.value {
                    if let venues = data.response?.venues {
                        // create coffeeShops
                        var coffeeShops: [CoffeeShop] = []
                        for venue in venues {
                            if let name = venue.name,
                                let address = venue.location?.address,
                                let distance = venue.location?.distance,
                                let latitude = venue.location?.lat,
                                let longitude = venue.location?.lng,
                                let phone = venue.contact?.phone
                            {
                                let coffeeShop = CoffeeShop()
                                coffeeShop.name = name
                                coffeeShop.address = address
                                coffeeShop.distance = distance
                                coffeeShop.latitude = latitude
                                coffeeShop.longitude = longitude
                                coffeeShop.phone = phone
                                coffeeShops.append(coffeeShop)
                            }
                        }
                        // sort
                        coffeeShops.sort(by: { (coffeeShop1, coffeeShop2) -> Bool in
                            let distance1 = coffeeShop1.distance ?? 0
                            let distance2 = coffeeShop2.distance ?? 0
                            return distance1 < distance2
                        })
                        // update view
                        self.view?.setCoffeeShopList(coffeeShops)
                    }
                }
                completion(nil)
            }
            else {
                let errorMessage = response.error != nil ? response.error!.localizedDescription : "network error"
                completion(errorMessage)
            }
        }
    }
}

