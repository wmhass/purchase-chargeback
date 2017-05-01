//
//  HomePresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol HomeViewWireframeProtocol {
    func launchNoticePage(fromURL url: URL, completion: @escaping () -> Void)
}

protocol HomeUserInterface: class {
    func showErrorMessage(_ message: String?)
    func refresh(withPage page: HomePage)
    func showLoadingContentState(_ shouldShow: Bool)
}

class HomePresenter {
    
    static let pageURL = URL(string: "https://nu-mobile-hiring.herokuapp.com/notice")
    
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
        if let url = URL(string: "https://nu-mobile-hiring.herokuapp.com/notice") {
            self.userInterface?.showLoadingContentState(true)
            self.wireframe?.launchNoticePage(fromURL: url) {
                self.userInterface?.showLoadingContentState(false)
            }
        }
    }

    func uiFinishedLoading() {
        if let url = HomePresenter.pageURL {
            self.userInterface?.showLoadingContentState(true)
            
            AppServerAPI.get(url: url, completion: { [weak self] (result: AppServerAPI.Result) in
                self?.userInterface?.showLoadingContentState(false)
                
                switch result {
                case .failed(let error):
                    self?.userInterface?.showErrorMessage(error)
                    break
                case .success(let rawPage):
                    self?.userInterface?.refresh(withPage: HomePage(raw: rawPage))
                    break
                }
            })
        }
    }
    
}
