//
//  HomePresenter.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol HomeViewWireframeProtocol {
    func launch(wireframeOfType: AppPageWireframe.Type, withPage rawPage: [String: AnyObject])
}

protocol HomeUserInterface: class {
    func showErrorMessage(_ message: String?)
    func refresh(withPage page: HomePage)
    func showLoadingContentState(_ shouldShow: Bool)
    func showEmptyState(_ shouldShow: Bool)
}

class HomePresenter {
    
    static let pageURL = URL(string: "https://nu-mobile-hiring.herokuapp.com")!
    
    weak var userInterface: HomeUserInterface?
    var wireframe: HomeViewWireframeProtocol?
    let api: AppServerAPIProtocol
    
    init(wireframe: HomeViewWireframeProtocol?, userInterface: HomeUserInterface?, api: AppServerAPIProtocol) {
        self.wireframe = wireframe
        self.userInterface = userInterface
        self.api = api
    }
    
    func apiRoutedLink(result: RouterResult) {
        self.userInterface?.showLoadingContentState(false)
        switch result {
        case .error(let errorMessage) where errorMessage != nil:
            self.userInterface?.showErrorMessage(errorMessage!)
            
        case .success(let wireframeType, let rawPage):
            self.wireframe?.launch(wireframeOfType: wireframeType, withPage: rawPage)
            
        default:
            let message = "appapi.error.unknown".localized(comment:  "Ocorreu um erro desconhecido. Por favor, tente novamente.")!
            self.userInterface?.showErrorMessage(message)
        }
    }
    
    func apiLoadedContent(result: AppServerAPIResponse) {
        self.userInterface?.showLoadingContentState(false)
        
        switch result {
        case .failed(let error):
            self.userInterface?.showEmptyState(true)
            self.userInterface?.showErrorMessage(error)
        case .success(let rawPage):
            self.userInterface?.showEmptyState(false)
            self.userInterface?.refresh(withPage: HomePage(raw: rawPage))
        }
    }
    
}

// MARK: - HomeUIEventHandler
extension HomePresenter: HomeUIEventHandler {
    
    func didSelectLink(_ link: AppApiLink) {
        self.userInterface?.showLoadingContentState(true)
        self.api.routeLink(appLink: link) { [weak self] (result) in
            self?.apiRoutedLink(result: result)
        }
        
    }

    func loadPageContent() {
        self.userInterface?.showLoadingContentState(true)
        self.api.get(url: HomePresenter.pageURL, completion: { [weak self] (result: AppServerAPIResponse) in
            self?.apiLoadedContent(result: result)
        })
    }
    
}
