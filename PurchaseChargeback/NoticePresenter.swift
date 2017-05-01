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
}

class NoticePresenter {
    
    var wireframe: NoticeWireframe
    weak var userInterface: NoticeUserInterface?
    
    init(wireframe: NoticeWireframe, userInterface: NoticeUserInterface) {
        self.wireframe = wireframe
        self.userInterface = userInterface
    }
}

// MARK: - NoticeUIEventHandler
extension NoticePresenter: NoticeUIEventHandler {
    
    func didTapAction(action: NoticePage.Action) {
        
    }
    
}
