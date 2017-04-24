//
//  ToggleCardStatusButton.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

enum ToggleCardStatusButtonStyle {
    case locked
    case unlocked
}

class ToggleCardStatusButton: UIButton {

    var style: ToggleCardStatusButtonStyle = .unlocked {
        didSet {
            self.refreshStyle()
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
        
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView?.clipsToBounds = true
        
        self.imageEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        self.contentEdgeInsets = UIEdgeInsets.zero
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.refreshStyle()
    }
    
    fileprivate func refreshStyle() {
        
        switch self.style {
        case .locked:
            let localizedTitle = "cardstatus.button.cardlocked".localized(comment: "Bloqueamos preventivamente o seu cartão")
            self.setTitle(localizedTitle, for: UIControlState.normal)
            self.setImage(AppImage.icChargebackLock?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        case .unlocked:
            let localizedTitle = "cardstatus.button.cardunlocked".localized(comment: "Cartão desbloqueado, recomendamos mantê-lo bloqueado.")
            self.setTitle(localizedTitle, for: UIControlState.normal)
            self.setImage(AppImage.icChargebackUnlock?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        }
    }
    
}
