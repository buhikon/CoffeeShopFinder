//
//  SplashViewController.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    private var presenter = SplashPresenter()
    private var logoImageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        
        // create and set UI
        view.backgroundColor = UIColor.Coffee.background
        
        logoImageView = UIImageView(image: UIImage(named: "coffee"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 172),
            logoImageView.heightAnchor.constraint(equalToConstant: 209),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
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
    
    /// animate center imageview
    ///
    /// - Parameter completion: this will be called after animation completely finish
    private func animateLogo(completion:@escaping (() -> Void)) {
        UIView.animate(withDuration: 0.3, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        },
                       completion: { (finish) in
                        UIView.animate(withDuration: 0.6,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.3,
                                       initialSpringVelocity: 0.0,
                                       options: UIViewAnimationOptions.curveEaseInOut,
                                       animations: {
                                        self.logoImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        },
                                       completion: { (finish) in
                                        completion()
                        })
        })
    }
}

extension SplashViewController : SplashView {
    func alert(text: String, completion: (() -> Void)?) {
        UIAlertController.alert(text: text, completion: completion)
    }
    func moveToCoffeeShopList() {
        animateLogo {
            self.navigationController?.setViewControllers([CoffeeShopListViewController()], animated: false)
        }
    }
}
