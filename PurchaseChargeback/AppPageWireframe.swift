//
//  AppPageWireframe.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol AppPageWireframe {
    static func launchModule(rawPage: [String: AnyObject], fromViewController: UIViewController)
}
