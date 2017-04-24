//
//  AttributedPlaceholderTextView.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/24/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class AttributedPlaceholderTextView: UITextView {
    
    var isEditing: Bool = false
    fileprivate let placeholderTextView = UITextView()
    
    var attributedPlaceholder: NSAttributedString? {
        set {
            self.placeholderTextView.attributedText = newValue
        }
        get {
            return self.placeholderTextView.attributedText
        }
    }
    
    override var text: String! {
        didSet {
            self.refreshLayout()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(AttributedPlaceholderTextView.textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(AttributedPlaceholderTextView.didBeginEditing), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(AttributedPlaceholderTextView.didEndEditing), name: NSNotification.Name.UITextViewTextDidEndEditing, object: self)

        self.setupPlaceholder()
        self.refreshLayout()
    }
    
    fileprivate func setupPlaceholder() {
        self.placeholderTextView.isUserInteractionEnabled = false
        self.placeholderTextView.backgroundColor = UIColor.clear
        self.placeholderTextView.frame = self.bounds
        self.placeholderTextView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.placeholderTextView.isScrollEnabled = false
        self.placeholderTextView.isEditable = false
        
        self.addSubview(self.placeholderTextView)
    }
    
    fileprivate func refreshLayout() {
        self.placeholderTextView.isHidden = self.text.characters.count > 0
    }
    
    @objc func textDidChange() {
        self.refreshLayout()
    }
    
    @objc func didBeginEditing() {
        self.isEditing = true
    }
    
    @objc func didEndEditing() {
        self.isEditing = false
    }
}
