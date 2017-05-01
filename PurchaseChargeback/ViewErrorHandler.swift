//
//  ViewErrorHandler.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol ViewErrorHandler {
    func hanldeErrorMessage(message: String?)
}

extension ViewErrorHandler where Self: UIViewController {
    func hanldeErrorMessage(message: String?) {
        let alertTitle = "appapi.error.generictitle".localized(comment: "Oops!")
        let alert = UIAlertController(title: title, message: alertTitle, preferredStyle: UIAlertControllerStyle.alert)
        
        let okTitle = "appapi.error.button.ok".localized(comment: "Okay")
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
