//
//  CoffeeShopMapHeaderView.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

protocol CoffeeShopMapHeaderViewDelegate : NSObjectProtocol {
    func coffeeShopMapHeaderViewDidTapBackButton()
    func makePhoneCall()
}

class CoffeeShopMapHeaderView: BaseView {
    
    weak var delegate: CoffeeShopMapHeaderViewDelegate? = nil
    
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    private var titleLabel: UILabel!
    private var backButton: UIButton!
    private var callButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.Coffee.background
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.bold(22.0)
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(titleLabel)
        
        backButton = UIButton(type: .custom)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel!.font = UIFont.light(17.0)
        backButton.addTarget(self, action: #selector(self.backButtonTapped(_:)) , for: .touchUpInside)
        self.addSubview(backButton)
        
        callButton = UIButton(type: .custom)
        callButton.setTitleColor(UIColor.white, for: .normal)
        callButton.setTitle("Call", for: .normal)
        callButton.titleLabel!.font = UIFont.light(17.0)
        callButton.addTarget(self, action: #selector(self.callButtonTapped(_:)) , for: .touchUpInside)
        self.addSubview(callButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            backButton.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8.0),
            backButton.topAnchor.constraint(equalTo: self.topAnchor),
            backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 60.0)
            ])
        NSLayoutConstraint.activate([
            callButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            callButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            callButton.topAnchor.constraint(equalTo: self.topAnchor),
            callButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            callButton.widthAnchor.constraint(equalToConstant: 60.0)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - event
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        delegate?.coffeeShopMapHeaderViewDidTapBackButton()
    }
    @IBAction private func callButtonTapped(_ sender: UIButton) {
        delegate?.makePhoneCall()
    }
}

