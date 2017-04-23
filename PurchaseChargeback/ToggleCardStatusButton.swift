//
//  ToggleCardStatusButton.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class ToggleCardStatusButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        self.contentMode = UIViewContentMode.scaleAspectFit
        
        self.setTitle("Hello as Hello as Hello Hello as ", for: UIControlState.normal)
        self.titleLabel?.numberOfLines = 2
        
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView?.clipsToBounds = true
        self.setImage(UIImage(named: "ic_chargeback_lock")?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        
        self.imageEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        self.contentEdgeInsets = UIEdgeInsets.zero
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
    }

}
