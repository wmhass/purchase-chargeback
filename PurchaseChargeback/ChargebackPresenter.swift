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
    weak var view: ChargebackUserInterface?
}

// MARK: - ChargebackUIEventHandler
extension ChargebackPresenter: ChargebackUIEventHandler {
    
}
