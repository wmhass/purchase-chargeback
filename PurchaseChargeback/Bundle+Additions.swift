//
//  Bundle+Additions.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit


extension Bundle {
    
    func loadCSSFile(named fileName: String) -> String? {
        do {
            if let filePath = self.path(forResource: fileName, ofType: "css") {
                return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            }
        } catch let error { print(error) }
        return nil
    }
    
}
