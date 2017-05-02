//
//  ChargebackPresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation


protocol ChargebackUserInterface: class {
    func showErrorMessage(_ message: String?)
    func setCardLocked(isLocked locked: Bool)
}

protocol ChargebackWireframeProtocol {
    
}


class ChargebackPresenter {
    
    let wireframe: ChargebackWireframeProtocol
    let api: AppServerAPIProtocol
    var userInterface: ChargebackUserInterface?
    
    init(wireframe: ChargebackWireframeProtocol, userInterface: ChargebackUserInterface, api: AppServerAPIProtocol) {
        self.wireframe = wireframe
        self.api = api
        self.userInterface = userInterface
    }
    
}

// MARK: - NoticeUIEventHandler
extension ChargebackPresenter: ChargebackUIEventHandler {
    
    func toggleCardStatus(fromPage: ChargebackPage) {
        guard let url = fromPage.isCardLocked ? fromPage.unlockCardURL : fromPage.lockCardURL else {
            return
        }
        
        self.api.post(url: url, object: nil) { [weak self] (response: AppServerAPIResponse) in
            switch response {
                
            case .failed(let message):
                self?.userInterface?.showErrorMessage(message)
                self?.userInterface?.setCardLocked(isLocked: fromPage.isCardLocked)
                
            case .success(let responseObject):
                if responseObject["status"] as? String == "Ok" {
                    self?.userInterface?.setCardLocked(isLocked: !fromPage.isCardLocked)
                } else {
                    self?.userInterface?.setCardLocked(isLocked: fromPage.isCardLocked)
                }
            }
        }
    }
    
    func submitPage(_ page: ChargebackPage) {
        guard let url = page.submitURL else {
            return
        }
        self.api.post(url: url, object: page.encodePage) { [weak self] (response: AppServerAPIResponse) in
            switch response {
            case .failed(let message):
                self?.userInterface?.showErrorMessage(message)
            case .success(let responseObject):
                if responseObject["status"] as? String == "Ok" {
                    
                }
            }
        }
    }
}
