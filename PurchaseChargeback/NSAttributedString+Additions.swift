//
//  NSAttributedString+Additions.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init?(html: String?) {
        guard let html = html else {
            return nil
        }
        let htmlData = html.data(using: String.Encoding.unicode)
        let htmlAttributedStringOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        
        do {
            try self.init(data: htmlData!, options: htmlAttributedStringOptions, documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
}
