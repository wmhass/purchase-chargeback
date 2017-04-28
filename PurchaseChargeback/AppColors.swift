//
//  AppColor.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

struct AppColor {
    
    static var chargebackTextViewStylesheet: String? = Bundle.main.loadCSSFile(named: "chargeback-textview")
    static var noticeDescriptionStylesheet: String? = Bundle.main.loadCSSFile(named: "notice-stylesheet")
    
    static let toggleCardStatusText = UIColor(r: 0xD5, g: 0x17, b: 0x1B)
    static let modalContentBgd = UIColor(r: 0xFD, g: 0xFD, b: 0xFD)
    static let titlePrimary = UIColor(r: 0x6E, g: 0x2B, b: 0x77)
    static let titleSecondary = UIColor(r: 0x80, g: 0x81, b: 0x91)
    static let titleSecondaryDisabled = UIColor(r: 0xCC, g: 0xCC, b: 0xCC)
    static let keylineBgd = UIColor(r: 0xDA, g: 0xDA, b: 0xDA)
    static let overlayBackground = UIColor.black.withAlphaComponent(0.6)
    
}
