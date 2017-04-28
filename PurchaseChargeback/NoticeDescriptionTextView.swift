//
//  NoticeDescriptionTextView.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class NoticeDescriptionTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        self.isScrollEnabled = false
        self.contentInset = UIEdgeInsets.zero
        self.textContainerInset = UIEdgeInsets.zero
        self.contentOffset = CGPoint.zero
        self.bounces = false
    }
    
    func setHTMLText(text: String?, appendingStyle: Bool) {
        guard var html = text else {
            return
        }

        if let stylesheet = AppColor.noticeDescriptionStylesheet, appendingStyle {
            html = "<style>" + stylesheet + "</style>" + html
        }
        
        do {
            let htmlData = html.data(using: String.Encoding.unicode)
            let htmlAttributedStringOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
            
            self.attributedText = try NSAttributedString(data: htmlData!, options: htmlAttributedStringOptions, documentAttributes: nil)
            
        } catch { }
    }
    
}
