//
//  UICustomSwitch.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/26/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

open class UICustomSwitch: UIView {
    
    fileprivate static let animationDuration: TimeInterval = 0.2
    
    private(set) var isOn: Bool = false
    open var offTintColor: UIColor = UIColor.lightGray {
        didSet {
            self.refreshView(animated: false)
        }
    }
    open var onTintColor: UIColor = UIColor.green {
        didSet {
            self.refreshView(animated: false)
        }
    }
    open var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.refreshView(animated: false)
        }
    }
    open var labelFont: UIFont? = UIFont.systemFont(ofSize: 8) {
        didSet {
            self.refreshView(animated: false)
        }
    }
    open var onLabel: String? {
        didSet {
            self.refreshView(animated: false)
        }
    }
    open var offLabel: String? {
        didSet {
            self.refreshView(animated: false)
        }
    }
    
    fileprivate let background: UIView = UIView()
    fileprivate let valueLabel: UILabel = UILabel()
    fileprivate let thumb: UIView = UIView()
    fileprivate let touchableAreaButton: UIButton = UIButton()
    fileprivate let thumbPadding: CGFloat = 1
    fileprivate var isPressed: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    var valueChanged: (_: UICustomSwitch) -> Void = { _ in }
    
    fileprivate func commonInit() {
        self.isAccessibilityElement = true
        self.accessibilityHint = "app.customswitch.hint".localized(comment: "Pressione para inverter valor")
        self.accessibilityTraits = UIAccessibilityTraitButton
        
        self.valueLabel.font = self.labelFont
        self.valueLabel.textAlignment = .center
        
        self.addSubview(self.background)
        self.addSubview(self.valueLabel)
        self.addSubview(self.thumb)
        self.addSubview(self.touchableAreaButton)
        
        self.touchableAreaButton.addTarget(self, action: #selector(UICustomSwitch.touchDown), for: .touchDown)
        self.touchableAreaButton.addTarget(self, action: #selector(UICustomSwitch.touchUpInside), for: .touchUpInside)
        self.touchableAreaButton.addTarget(self, action: #selector(UICustomSwitch.touchUpOutside), for: .touchUpOutside)
        
        self.setOn(self.isOn, animated: false)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.thumb.backgroundColor = self.thumbTintColor
        self.valueLabel.textColor = self.thumbTintColor
        
        self.touchableAreaButton.frame = self.bounds
        self.background.frame = self.bounds
        self.background.layer.cornerRadius = self.background.frame.height/2
        
        let thumbDiameter = self.frame.height - (2*self.thumbPadding)
        self.thumb.layer.cornerRadius = thumbDiameter/2
        
        if !self.isPressed {
            self.thumb.frame.size = CGSize(width: thumbDiameter, height: thumbDiameter)
        } else {
            self.thumb.frame.size.width = thumbDiameter * 1.5
        }
        
        self.valueLabel.frame.size = CGSize(width: self.frame.size.width-thumbDiameter, height: self.frame.height)
        
        if self.isOn {
            self.background.backgroundColor = self.onTintColor
            self.thumb.frame.origin = CGPoint(x: self.frame.width - self.thumbPadding - self.thumb.frame.size.width, y: self.thumbPadding)
            
            self.valueLabel.text = self.onLabel
            self.valueLabel.frame.origin = CGPoint(x: 0, y: 0)
            
        } else {
            self.background.backgroundColor = self.offTintColor
            self.thumb.frame.origin = CGPoint(x: self.thumbPadding, y: self.thumbPadding)
            
            self.valueLabel.text = self.offLabel
            let valueXPosition = self.frame.size.width - self.valueLabel.frame.size.width
            self.valueLabel.frame.origin = CGPoint(x: valueXPosition, y: 0)
        }
    }
    
    func setOn(_ on: Bool, animated: Bool) {
        self.isOn = on
        self.refreshView(animated: animated)
        self.valueChanged(self)
    }

    fileprivate func reloadAccessibility() {
        if self.isOn {
            self.accessibilityLabel = self.onLabel
        } else {
            self.accessibilityLabel = self.offLabel
        }
    }
    
    fileprivate func refreshView(animated: Bool) {
        self.reloadAccessibility()
        self.setNeedsLayout()
        if animated {
            UIView.animate(withDuration: UICustomSwitch.animationDuration, delay: 0, options: .curveEaseOut, animations: { 
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            self.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func touchDown() {
        self.isPressed = true
        self.refreshView(animated: true)
    }
    
    @objc fileprivate func touchUpInside() {
        self.isPressed = false
        self.setOn(!self.isOn, animated: true)
    }
    
    @objc fileprivate func touchUpOutside() {
        self.isPressed = false
        self.setOn(!self.isOn, animated: true)
    }
}
