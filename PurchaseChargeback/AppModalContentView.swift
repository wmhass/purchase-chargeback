//
//  AppModalContentView.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class AppModalContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.keylineBgd.cgColor
        
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        self.backgroundColor = AppColor.modalContentBgd
    }
    
}
