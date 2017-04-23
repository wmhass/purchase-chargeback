//
//  AppColor.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

struct AppColor {
    
    static let modalContentBgd = UIColor(r: 0xFD, g: 0xFD, b: 0xFD)
    
    static var noticeDescriptionStylesheet: String? = {
        do {
            if let filePath = Bundle.main.path(forResource: "notice-stylesheet", ofType: "css") {
                return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            }
        } catch let error { print(error) }
        return nil
    }()
    
    static let titlePrimary = UIColor(r: 0x6E, g: 0x2B, b: 0x77)
    static let titleSecondary = UIColor(r: 0x80, g: 0x81, b: 0x91)
    static let keylineBgd = UIColor(r: 0xDA, g: 0xDA, b: 0xDA)
    
}
