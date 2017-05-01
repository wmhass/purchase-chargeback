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
    
    static func launchWithNavigationController(_ navigationController: UINavigationController) {
        let wireframe = HomeViewWireframe(navigationController: navigationController)
        let homeViewController = HomeViewController()
        
        let viewEventHandler = HomePresenter(wireframe: wireframe, userInterface: homeViewController)
        
        homeViewController.evenHandler = viewEventHandler
        
        navigationController.setViewControllers([homeViewController], animated: false)
    }

}

// MARK: - HomeViewWireframeProtocol
extension HomeViewWireframe: HomeViewWireframeProtocol {
    func launchNoticePage(_ page: NoticePage) {
    }
}
