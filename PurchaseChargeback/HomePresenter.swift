//
//  HomePresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol HomeViewWireframeProtocol {
    func launchNoticePage(_ page: NoticePage)
}

protocol HomeUserInterface: class, ViewErrorHandler {
    
}

class HomePresenter {
    
    weak var userInterface: HomeUserInterface?
    var wireframe: HomeViewWireframeProtocol?
    
    init(wireframe: HomeViewWireframeProtocol, userInterface: HomeUserInterface) {
        self.wireframe = wireframe
        self.userInterface = userInterface
    }
    
}

// MARK: - HomeUIEventHandler
extension HomePresenter: HomeUIEventHandler {
    
    func beginChargebackFlow() {
        
        /*AppServerAPI.get(resource: AppServerAPI.Resource.notice) { [weak self] (result) in
            switch result {
            case .failed(let message):
                self?.userInterface?.hanldeErrorMessage(message: message)
            case .success(let object):
                let page = NoticePage(raw: object)
                self?.wireframe?.launchNoticePage(page)
            }
        }*/
        
    }
    
}
