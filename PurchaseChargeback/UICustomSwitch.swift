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
    
    fileprivate let background: UIView = UIView()
    fileprivate let valueLabel: UILabel = UILabel()
    fileprivate let thumb: UIView = UIView()
    fileprivate let touchableAreaButton: UIButton = UIButton()
    fileprivate let offBackgorundIndicator: UIView = UIView()
    
    var thumbMaxStretchScale: CGFloat = 1.3
    
    
    var thumbPadding: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    /*open var isOn: Bool = false
    open var onTintColor: UIColor?
    open var thumbTintColor: UIColor?
    open var onText: String?
    open var offText: String?*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        self.background.backgroundColor = UIColor.gray
        self.thumb.backgroundColor = UIColor.yellow
        self.thumb.layer.anchorPoint = CGPoint(x: 0, y: 0)
        self.offBackgorundIndicator.backgroundColor = UIColor.blue
        self.offBackgorundIndicator.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        self.addSubview(self.background)
        self.addSubview(self.offBackgorundIndicator)
        self.addSubview(self.valueLabel)
        self.addSubview(self.thumb)
        self.addSubview(self.touchableAreaButton)
        
        self.touchableAreaButton.addTarget(self, action: #selector(UICustomSwitch.touchDown), for: .touchDown)
        self.touchableAreaButton.addTarget(self, action: #selector(UICustomSwitch.touchUpInside), for: .touchUpInside)
        self.touchableAreaButton.addTarget(self, action: #selector(UICustomSwitch.touchUpOutside), for: .touchUpOutside)
        self.touchableAreaButton.addTarget(self, action: #selector(UICustomSwitch.touchDragOutside), for: .touchDragOutside)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.touchableAreaButton.frame = self.bounds
        self.background.frame = self.bounds
        self.background.layer.cornerRadius = self.background.frame.height/2
        
        
        if !self.touchableAreaButton.isTouchInside {
            let thumbDiameter = self.background.frame.height - (2*thumbPadding)
            self.thumb.frame = CGRect(x: self.thumbPadding, y: self.thumbPadding, width: thumbDiameter, height: thumbDiameter)
            self.thumb.layer.cornerRadius = thumbDiameter/2
            
            let padding: CGFloat = 1
            self.offBackgorundIndicator.frame = CGRect(x: padding, y: padding, width: self.bounds.width - (2*padding), height: self.bounds.height - (2*padding))
            self.offBackgorundIndicator.layer.cornerRadius = self.offBackgorundIndicator.frame.height/2
        }
    }
    
    func setOn(_ on: Bool, animated: Bool) {
        
    }
    
    @objc fileprivate func touchDown() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.thumb.frame.size.width = self.thumb.frame.height * self.thumbMaxStretchScale
            //self.offBackgorundIndicator.alpha = 0
            self.offBackgorundIndicator.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: nil)
    }
    
    @objc fileprivate func touchDragInside() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.thumb.frame.size.width = self.thumb.frame.height * self.thumbMaxStretchScale
            //self.offBackgorundIndicator.alpha = 0
            self.offBackgorundIndicator.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: nil)
    }
    
    @objc fileprivate func touchUpInside() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.thumb.frame.size.width = self.thumb.frame.height
            //self.offBackgorundIndicator.alpha = 1
            self.offBackgorundIndicator.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    @objc fileprivate func touchUpOutside() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.thumb.frame.size.width = self.thumb.frame.height
            //self.offBackgorundIndicator.alpha = 1
            self.offBackgorundIndicator.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    @objc fileprivate func touchDragOutside() {
        
    }
    
    
    
}
