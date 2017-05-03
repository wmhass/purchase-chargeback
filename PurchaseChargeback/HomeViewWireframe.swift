//
//  HomeViewWireframe.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit


class HomeViewWireframe {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createNavigation() -> UINavigationController {
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)

        let wireframe = HomeViewWireframe(navigationController: navigationController)
        
        let api = AppServerAPI()
        
        let viewEventHandler = HomePresenter(wireframe: wireframe, userInterface: homeViewController, api: api)
        
        homeViewController.evenHandler = viewEventHandler
        
        return navigationController
    }
}



// MARK: - HomeViewWireframeProtocol
extension HomeViewWireframe: HomeViewWireframeProtocol {
    func launch(wireframeOfType: AppPageWireframe.Type, withPage rawPage: [String: AnyObject]) {
        guard let navigationController = navigationController else {
            return
        }
        wireframeOfType.launchModule(rawPage: rawPage, fromViewController: navigationController)
    }
}
