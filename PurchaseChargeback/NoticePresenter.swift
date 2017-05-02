//
//  NoticePresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

protocol NoticeUserInterface: class {
    func presentPage(_ page: NoticePage)
    func showLoadingContentState(_ shouldShow: Bool)
}

protocol NoticeWireframeProtocol {
    func dismiss(completion: (() -> Void)?)
    func continueActionTapped(page: NoticePage, completion: @escaping () -> Void)
}

class NoticePresenter {
    
    let wireframe: NoticeWireframeProtocol
    weak var userInterface: NoticeUserInterface?
    let api: AppServerAPIProtocol
    
    init(wireframe: NoticeWireframeProtocol, userInterface: NoticeUserInterface, api: AppServerAPIProtocol) {
        self.wireframe = wireframe
        self.userInterface = userInterface
        self.api = api
    }
}

// MARK: - NoticeUIEventHandler
extension NoticePresenter: NoticeUIEventHandler {
    
    func didTapAction(action: NoticePage.Action, inPage page: NoticePage) {
        if action.type == .`continue` {
            self.userInterface?.showLoadingContentState(true)
            self.wireframe.continueActionTapped(page: page) { [weak self] in
                self?.userInterface?.showLoadingContentState(false)
            }

        } else {
            self.wireframe.dismiss(completion: nil)
        }
    }
    
}
