//
//  ChargebackPresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation


protocol ChargebackUserInterface: class, AppUserInterface {
    func setCardLocked(isLocked locked: Bool)
}

protocol ChargebackWireframeProtocol {
    func chargebackDone()
    func chargebackCanceled()
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
    
    func didToggleCardStatus(fromPage: ChargebackPage, response: AppServerAPIResponse) {
        switch response {
            
        case .failed(let message):
            self.userInterface?.showErrorMessage(message)
            self.userInterface?.setCardLocked(isLocked: fromPage.isCardLocked)
            
        case .success(let responseObject):
            if responseObject["status"] as? String == "Ok" {
                self.userInterface?.setCardLocked(isLocked: !fromPage.isCardLocked)
            } else {
                self.userInterface?.setCardLocked(isLocked: fromPage.isCardLocked)
            }
        }
    }
    
    func didSubmitPage(response: AppServerAPIResponse) {
        self.userInterface?.showLoadingContentState(false)
        switch response {
        case .failed(let message):
            self.userInterface?.showErrorMessage(message)
        case .success(let responseObject) where responseObject["status"] as? String == "Ok":
            self.wireframe.chargebackDone()
        default:
            let error = "appapi.error.unknown".localized(comment: "Ocorreu um erro desconhecido. Por favor, tente novamente.")
            self.userInterface?.showErrorMessage(error)
        }
    }
}

// MARK: - NoticeUIEventHandler
extension ChargebackPresenter: ChargebackUIEventHandler {
    
    func didTapCancel() {
        self.wireframe.chargebackCanceled()
    }
    
    func toggleCardStatus(fromPage: ChargebackPage) {
        guard let url = fromPage.isCardLocked ? fromPage.unlockCardURL : fromPage.lockCardURL else {
            return
        }
        self.api.post(url: url, object: nil) { [weak self] (response: AppServerAPIResponse) in
            self?.didToggleCardStatus(fromPage: fromPage, response: response)
        }
    }
    
    func submitPage(_ page: ChargebackPage) {
        guard let url = page.submitURL else {
            return
        }
        self.userInterface?.showLoadingContentState(true)
        self.api.post(url: url, object: page.encodePage) { [weak self] (response: AppServerAPIResponse) in
            self?.didSubmitPage(response: response)
        }
    }
}
