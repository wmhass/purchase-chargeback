//
//  AppUserInterface.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/3/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

import SVProgressHUD

protocol AppUserInterface {
    func showLoadingContentState(_ shouldShow: Bool)
    func showErrorMessage(_ message: String?)
}

extension AppUserInterface {
    func showLoadingContentState(_ shouldShow: Bool) {
        if shouldShow {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
}

extension AppUserInterface where Self: UIViewController {
    func showErrorMessage(_ message: String?) {
        let alertTitle = "appapi.error.generictitle".localized(comment: "Oops!")
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okTitle = "appapi.error.button.ok".localized(comment: "Okay")
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
