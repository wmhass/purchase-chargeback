//
//  NoticePresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

protocol NoticeUserInterface: class {
    
}

struct NoticePresenter {
    
    weak var view: NoticeUserInterface?
    
}

// MARK: - NoticeViewControllerUIEventHandler
extension NoticePresenter: NoticeViewControllerUIEventHandler {
    
}
