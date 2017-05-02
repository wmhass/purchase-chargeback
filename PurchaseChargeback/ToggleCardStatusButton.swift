//
//  ToggleCardStatusButton.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

enum ToggleCardStatusButtonMode {
    case locked
    case unlocked
}

class ToggleCardStatusButton: UIButton {

    var mode: ToggleCardStatusButtonMode = .unlocked {
        didSet {
            self.refreshMode()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                self.alpha = 1
            } else {
                self.alpha = 0.6
            }
        }
    }
    
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

        self.titleLabel?.numberOfLines = 2
        self.titleLabel?.font = AppFont.toggleCardStatus
        self.setTitleColor(AppColor.toggleCardStatusText, for: UIControlState.normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView?.clipsToBounds = true
        
        self.imageEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        self.contentEdgeInsets = UIEdgeInsets.zero
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        self.refreshMode()
    }
    
    fileprivate func refreshMode() {
        switch self.mode {
        case .locked:
            let localizedTitle = "cardstatus.button.cardlocked".localized(comment: "Bloqueamos preventivamente o seu cartão")
            self.setTitle(localizedTitle, for: UIControlState.normal)
            self.setImage(UIImage(named: "ic_chargeback_lock")?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        case .unlocked:
            let localizedTitle = "cardstatus.button.cardunlocked".localized(comment: "Cartão desbloqueado, recomendamos mantê-lo bloqueado.")
            self.setTitle(localizedTitle, for: UIControlState.normal)
            self.setImage(UIImage(named: "ic_chargeback_unlock")?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        }
    }
    
}
