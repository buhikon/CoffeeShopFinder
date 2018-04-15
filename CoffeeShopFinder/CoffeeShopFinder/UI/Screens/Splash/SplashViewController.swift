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
    var imageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.Coffee.background
        
        imageView = UIImageView(image: UIImage(named: "coffee"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 172),
            imageView.heightAnchor.constraint(equalToConstant: 209),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
    private func animateLogo(completion:@escaping (() -> Void)) {
        UIView.animate(withDuration: 2.0,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                        self.imageView.alpha = 0.0
        },
                       completion: { (finish) in
                        completion()
        })
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
