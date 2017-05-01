//
//  ChargebackPresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation


protocol ChargebackUserInterface: class {
    
}


struct ChargebackPresenter {
    weak var userInterface: ChargebackUserInterface?
}

// MARK: - NoticeUIEventHandler
extension ChargebackPresenter: NoticeUIEventHandler {
    func didTapAction(action: NoticePage.Action) {
        
    }
}
