//
//  UICustomSwitch.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/26/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

// This view could have a nib, but it was done programatically for sample purpose.
open class UICustomSwitch: UIView {
    
    fileprivate static let animationDuration: TimeInterval = 0.2
    
    open var isOn: Bool = false
    open var offTintColor: UIColor = UIColor.lightGray
    open var onTintColor: UIColor = UIColor.green
    open var thumbTintColor: UIColor = UIColor.white
    open var onLabel: String?
    open var offLabel: String?
    open var labelFont: UIFont? = UIFont.systemFont(ofSize: 8)
    
    fileprivate var isPressed: Bool = false
    fileprivate let background: UIView = UIView()
    fileprivate let valueLabel: UILabel = UILabel()
    fileprivate let thumb: UIView = UIView()
    fileprivate let touchableAreaButton: UIButton = UIButton()
    
    var thumbMaxStretchScale: CGFloat = 1.3
    
    
    var thumbPadding: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
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
            self.thumb.frame.size.width = thumbDiameter * self.thumbMaxStretchScale
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
    }

    fileprivate func refreshView(animated: Bool) {
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
