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

protocol ChargebackWireframeProtocol {
    
}


struct ChargebackPresenter {
    
    weak var userInterface: ChargebackUserInterface?
    let wireframe: ChargebackWireframeProtocol
    
    init(wireframe: ChargebackWireframeProtocol, userInterface: ChargebackUserInterface) {
        self.wireframe = wireframe
    }
    
}

// MARK: - NoticeUIEventHandler
extension ChargebackPresenter: ChargebackUIEventHandler {
    
}
