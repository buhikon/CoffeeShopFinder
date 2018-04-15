//
//  CoffeeShopMapViewController.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit
import MapKit

class CoffeeShopMapViewController: BaseViewController {
    
    var coffeeShop: CoffeeShop?
    
    private var headerView: CoffeeShopMapHeaderView!
    private var mapView: MKMapView!
    
    override func loadView() {
        extendMainViewToBottom = true
        super.loadView()
        
        // create and set UI
        view.backgroundColor = UIColor.Coffee.background
        
        let headerHeight = 50
        
        headerView = CoffeeShopMapHeaderView(frame: CGRect(x: 0, y: 0, width: Int(mainView.bounds.size.width), height: headerHeight))
        headerView.autoresizingMask = [.flexibleWidth]
        headerView.title = coffeeShop?.name
        headerView.delegate = self
        mainView.addSubview(headerView)
        
        mapView = MKMapView(frame: CGRect(x: 0, y: headerHeight, width: Int(mainView.bounds.size.width), height: Int(mainView.bounds.size.height) - headerHeight))
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsBuildings = true
        mainView.addSubview(mapView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        centerMapOnCoffeeShop()
        addAnnotationOfCoffeeShop()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - private functions
    /// close view controller (pop)
    private func close() {
        self.navigationController?.popViewController(animated: true)
    }
    /// set the region so that coffee can be on center of mapview.
    /// and change pitch, so that buildings in the mapview will be 3D mode.
    private func centerMapOnCoffeeShop() {
        if let latitude = coffeeShop?.latitude, let longitude = coffeeShop?.longitude {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500)
            let mapCamera = MKMapCamera()
            mapCamera.centerCoordinate = coordinate
            mapCamera.pitch = 20
            mapCamera.altitude = 500
            
            // set properties
            mapView.region = region
            mapView.camera = mapCamera
        }
    }
    /// add annotation of coffee shop in mapview.
    private func addAnnotationOfCoffeeShop() {
        if let coffeeShop = coffeeShop {
            let annotation = CoffeeShopMapAnnotation(coffeeShop: coffeeShop)
            mapView.addAnnotation(annotation)
        }
    }
    
}

extension CoffeeShopMapViewController: CoffeeShopMapHeaderViewDelegate {
    func coffeeShopMapHeaderViewDidTapBackButton() {
        close()
    }
    func makePhoneCall() {
        guard let phone = coffeeShop?.phone else { return }
        guard let number = URL(string: "tel://" + phone) else { return }
        UIApplication.shared.open(number)
    }
}
extension CoffeeShopMapViewController: MKMapViewDelegate {
    
}

