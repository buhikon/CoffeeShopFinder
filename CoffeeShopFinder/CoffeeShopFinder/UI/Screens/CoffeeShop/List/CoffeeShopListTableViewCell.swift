//
//  CoffeeShopListTableViewCell.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

class CoffeeShopListTableViewCell: BaseTableViewCell {
    
    var coffeeShop: CoffeeShop?
    
    var nameLabel: UILabel!
    var addressLabel: UILabel!
    var distanceLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        nameLabel.font = UIFont.bold(18.0)
        nameLabel.textColor = UIColor.Coffee.background
        addressLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 300, height: 20))
        addressLabel.font = UIFont.light(12.0)
        distanceLabel = UILabel(frame: CGRect(x: 200, y: 0, width: 100, height: 20))
        distanceLabel.font = UIFont.light(12.0)
        distanceLabel.textAlignment = .right
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(distanceLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        distanceLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        distanceLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25.0)
            ])
        NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5.0),
            distanceLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)
            ])
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - public functions
    public func update(coffeeShop: CoffeeShop) {
        self.coffeeShop = coffeeShop
        
        nameLabel.text = coffeeShop.name
        addressLabel.text = coffeeShop.address
        if let distance = coffeeShop.distance {
            distanceLabel.text = "\(distance.withCommas()) m"
        }
        else {
            distanceLabel.text = "unknown"
        }
        
    }
    
}

