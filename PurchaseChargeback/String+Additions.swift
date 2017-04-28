//
//  String+Additions.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

protocol StyleSheetString {
    func css() -> String
}

extension String: StyleSheetString {
    func css() -> String {
        return "<style>" + self + "</style>"
    }
}

extension String {
    
    func localized(comment: String) -> String? {
        return NSLocalizedString(self, comment: comment)
    }
    
}
