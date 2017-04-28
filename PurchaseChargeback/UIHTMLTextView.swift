//
//  UIHTMLTextView.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol UIHTMLTextView {
    func setHTMLText(text: String?, styleSheet: StyleSheetString?)
}


extension UITextView: UIHTMLTextView {
    
    func setHTMLText(text: String?, styleSheet: StyleSheetString? = nil) {
        guard var htmlText = text else {
            self.attributedText = nil
            self.text = nil
            return
        }
        if let styleSheet = styleSheet {
            htmlText = styleSheet.css() + htmlText
        }
        self.attributedText = NSAttributedString(html: htmlText)
    }
    
}
