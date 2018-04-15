//
//  CoffeeShopListViewController.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Toast_Swift

class CoffeeShopListViewController: BaseViewController {
    
    private var presenter = CoffeeShopListPresenter()
    private var headerView: CoffeeShopListHeaderView!
    private var tableView: UITableView!
    private var coffeeShops: [CoffeeShop] = []
    private var locationOffViewController: LocationOffViewController?
    
    deinit {
        removeNotificationObserver()
    }
    
    override func loadView() {
        extendMainViewToBottom = true
        super.loadView()
        
        // create and set UI
        view.backgroundColor = UIColor.Coffee.background
        
        let headerHeight = 50
        
        headerView = CoffeeShopListHeaderView(frame: CGRect(x: 0, y: 0, width: Int(mainView.bounds.size.width), height: headerHeight))
        headerView.autoresizingMask = [.flexibleWidth]
        headerView.delegate = self
        headerView.title = "Coffee Shops"
        mainView.addSubview(headerView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: headerHeight, width: Int(mainView.bounds.size.width), height: Int(mainView.bounds.size.height) - headerHeight), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(CoffeeShopListTableViewCell.self, forCellReuseIdentifier: "CoffeeShopListTableViewCell")
        mainView.addSubview(tableView)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        
        // check location authorization
        presenter.checkLocationAuthorization()
        addNotificationObserver()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        headerView.stopTimer()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - private functions
    private func moveToCoffeeShopMap(coffeeShop: CoffeeShop) {
        let vc = CoffeeShopMapViewController()
        vc.coffeeShop = coffeeShop
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: notification
    /// add notification observer
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(CoffeeShopListViewController.locationAuthorizationDidChange(notification:)), name: LocationManager.NotificationAuthorizationChange, object: nil)
    }
    /// remove notification observer
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self, name: LocationManager.NotificationAuthorizationChange, object: nil)
    }
    /// this function will be called when *LocationManager.NotificationAuthorizationChange* fired.
    ///
    /// - Parameter notification: Notification
    @objc private func locationAuthorizationDidChange(notification: Notification) {
        presenter.checkLocationAuthorization()
    }
    
}

extension CoffeeShopListViewController: CoffeeShopListView {
    func setCoffeeShopList(_ coffeeShops: [CoffeeShop]) {
        self.coffeeShops = coffeeShops
        self.tableView.reloadData()
    }
    func presentLocationOffViewController() {
        if locationOffViewController == nil {
            locationOffViewController = LocationOffViewController()
            self.present(locationOffViewController!, animated: false, completion: nil)
        }
    }
    func dismissLocationOffViewController() {
        if let locationOffViewController = self.locationOffViewController {
            locationOffViewController.dismiss(animated: false, completion: nil)
            self.locationOffViewController = nil
        }
    }
    func showLoadingOnHeaderView() {
        headerView.showLoading()
    }
    func hideLoadingAndStartTimerOnHeaderView(interval: TimeInterval) {
        headerView.hideLoading()
        headerView.startTimer(interval: interval)
    }
    func makeToast(_ text: String?) {
        view.makeToast(text)
    }
}

extension CoffeeShopListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeShopListTableViewCell", for: indexPath) as! CoffeeShopListTableViewCell
        cell.update(coffeeShop: coffeeShops[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToCoffeeShopMap(coffeeShop: coffeeShops[indexPath.row])
    }
}

extension CoffeeShopListViewController: CoffeeShopListHeaderViewDelegate {
    func coffeeShopListHeaderViewDidTrigger() {
        presenter.reloadData()
    }
}


