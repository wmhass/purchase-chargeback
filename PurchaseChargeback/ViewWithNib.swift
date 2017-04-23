//
//  ViewWithNib.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol ViewWithNib {
}

extension ViewWithNib where Self: UIView {
    static var nib: UINib? {
        return UINib(nibName: String(describing: self.classForCoder()), bundle: Bundle(for: self))
    }
}

extension UITableViewCell: ViewWithNib {
    static var defaultReuseIdentifier: String {
        return String(describing: self.classForCoder())
    }
}
