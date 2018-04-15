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

protocol CoffeeShopListView {
    func setCoffeeShopList(_ coffeeShops: [CoffeeShop])
    func presentLocationOffViewController()
    func dismissLocationOffViewController()
    func showLoadingOnHeaderView()
    func hideLoadingAndStartTimerOnHeaderView(interval: TimeInterval)
    func makeToast(_ text: String?)
}

class CoffeeShopListPresenter: BasePresenter {
    var view: CoffeeShopListView?
    
    func checkLocationAuthorization() {
        if LocationManager.shared.isGranted == false {
            view?.presentLocationOffViewController()
        }
        else {
            view?.dismissLocationOffViewController()
        }
    }
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
                                let distance = venue.location?.distance
                            {
                                let coffeeShop = CoffeeShop()
                                coffeeShop.name = name
                                coffeeShop.address = address
                                coffeeShop.distance = distance
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

