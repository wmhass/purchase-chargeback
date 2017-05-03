//
//  NoticePresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

protocol NoticeUserInterface: class, AppUserInterface {
    func presentPage(_ page: NoticePage)
}

protocol NoticeWireframeProtocol {
    func dismiss(completion: (() -> Void)?)
    func launch(wireframeOfType: AppPageWireframe.Type, withPage rawPage: [String: AnyObject])
}

class NoticePresenter {
    
    let wireframe: NoticeWireframeProtocol
    weak var userInterface: NoticeUserInterface?
    let api: AppServerAPIProtocol
    let continueActionLinkName = "chargeback"
    
    init(wireframe: NoticeWireframeProtocol, userInterface: NoticeUserInterface, api: AppServerAPIProtocol) {
        self.wireframe = wireframe
        self.userInterface = userInterface
        self.api = api
    }
    
    func routeLink(_ link: AppApiLink) {
        self.userInterface?.showLoadingContentState(true)
        self.api.routeLink(appLink: link, completion: { [weak self] (result) in
            self?.userInterface?.showLoadingContentState(false)
            
            switch result {
            case .error(let errorMessage) where errorMessage != nil:
                self?.userInterface?.showErrorMessage(errorMessage!)
                
            case .success(let wireframeType, let rawPage):
                self?.wireframe.launch(wireframeOfType: wireframeType, withPage: rawPage)
                break
                
            default:
                let message = "appapi.error.unknown".localized(comment:  "Ocorreu um erro desconhecido. Por favor, tente novamente.")!
                self?.userInterface?.showErrorMessage(message)
            }
        })
    }
}

// MARK: - NoticeUIEventHandler
extension NoticePresenter: NoticeUIEventHandler {
    
    func didTapAction(action: NoticePage.Action, inPage page: NoticePage) {
        if action.type == .`continue` {
            if let link = page.link(withName: self.continueActionLinkName) {
                self.routeLink(link)
            }
        } else {
            self.wireframe.dismiss(completion: nil)
        }
    }
    
}
