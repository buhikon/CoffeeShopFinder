//
//  CoffeeShopListHeaderView.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol CoffeeShopListHeaderViewDelegate : NSObjectProtocol {
    /// this will be called when,
    ///   - timer fired
    ///   - user taps *Reload* button
    func coffeeShopListHeaderViewDidTrigger()
}

class CoffeeShopListHeaderView: BaseView {
    
    weak var delegate: CoffeeShopListHeaderViewDelegate? = nil
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    private var titleLabel: UILabel!
    private var reloadButton: UIButton!
    private var loadingView: NVActivityIndicatorView!
    private var timer: Timer? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // create and set UI
        backgroundColor = UIColor.Coffee.background
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.bold(22.0)
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(titleLabel)
        
        reloadButton = UIButton(type: .custom)
        reloadButton.setTitleColor(UIColor.white, for: .normal)
        reloadButton.setTitle("Reload", for: .normal)
        reloadButton.titleLabel!.font = UIFont.light(17.0)
        reloadButton.addTarget(self, action: #selector(self.reloadButtonTapped(_:)) , for: .touchUpInside)
        self.addSubview(reloadButton)
        
        loadingView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30), type: NVActivityIndicatorType.ballScaleRippleMultiple, color: UIColor.white, padding: nil)
        self.addSubview(loadingView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            reloadButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            reloadButton.topAnchor.constraint(equalTo: self.topAnchor),
            reloadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8.0),
            reloadButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 100.0)
            ])
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: reloadButton.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: reloadButton.centerYAnchor)
            ])
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - internal functions
    
    /// show loading indicator
    func showLoading() {
        reloadButton.isHidden = true
        loadingView.startAnimating()
    }
    /// hide loading indicator
    func hideLoading() {
        reloadButton.isHidden = false
        loadingView.stopAnimating()
    }
    /// start timer
    ///
    /// - Parameter interval: if 10.0, timer will be fired 10 secs later
    func startTimer(interval: TimeInterval) {
        stopTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { (timer) in
            self.trigger()
        })
    }
    /// stop timer
    func stopTimer() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    // MARK: - event
    @IBAction private func reloadButtonTapped(_ sender: UIButton) {
        trigger()
    }
    
    // MARK: - private functions
    
    /// timer fired or *Reload* button tapped
    private func trigger() {
        stopTimer()
        if let delegate = self.delegate {
            delegate.coffeeShopListHeaderViewDidTrigger()
        }
    }
    
    
}

