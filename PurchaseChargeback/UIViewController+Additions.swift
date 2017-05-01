//
//  UIViewController+Additions.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/1/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit
extension UIViewController {
    func handleErrorMessage(_ message: String?) {
        let alertTitle = "appapi.error.generictitle".localized(comment: "Oops!")
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okTitle = "appapi.error.button.ok".localized(comment: "Okay")
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
