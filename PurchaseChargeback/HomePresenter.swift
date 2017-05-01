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
    
    static let pageURL = URL(string: "https://nu-mobile-hiring.herokuapp.com")!
    
    weak var userInterface: HomeUserInterface?
    var wireframe: HomeViewWireframeProtocol?
    let api: AppServerAPIProtocol
    
    init(wireframe: HomeViewWireframeProtocol, userInterface: HomeUserInterface, api: AppServerAPIProtocol) {
        self.wireframe = wireframe
        self.userInterface = userInterface
        self.api = api
    }
}

// MARK: - HomeUIEventHandler
extension HomePresenter: HomeUIEventHandler {
    
    func didSelectLink(_ link: AppApiLink) {
        self.userInterface?.showLoadingContentState(true)
        self.wireframe?.launchNoticePage(fromURL: link.url) {
            self.userInterface?.showLoadingContentState(false)
        }
    }

    func loadPageContent() {
        self.userInterface?.showLoadingContentState(true)
        
        self.api.get(url: HomePresenter.pageURL, completion: { [weak self] (result: AppServerAPIResponse) in
            self?.userInterface?.showLoadingContentState(false)
            switch result {
            case .failed(let error):
                self?.userInterface?.showErrorMessage(error)
            case .success(let rawPage):
                self?.userInterface?.refresh(withPage: HomePage(raw: rawPage))
            }
        })
    }
    
}
