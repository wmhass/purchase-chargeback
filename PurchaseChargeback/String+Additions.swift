//
//  String+Additions.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

extension String {
    
    func localized(comment: String) -> String? {
        return NSLocalizedString(self, comment: comment)
    }
    
}
