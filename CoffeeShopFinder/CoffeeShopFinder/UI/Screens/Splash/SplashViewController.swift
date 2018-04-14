//
//  SplashViewController.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    var presenter = SplashPresenter()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.Coffee.background
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        presenter.requestWhenInUseAuthorization()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - private functions
    private func animateLogo(completion: @escaping (() -> Void)) {
        //TODO: implement an animation later...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            completion()
        }
    }
}

extension SplashViewController : SplashView {
    func alert(text: String, completion: (() -> Void)?) {
        UIAlertController.alert(text: text, completion: completion)
    }
    func moveToLocationList() {
        animateLogo {
            self.navigationController?.pushViewController(CoffeeShopListViewController(), animated: false)
        }
    }
}
