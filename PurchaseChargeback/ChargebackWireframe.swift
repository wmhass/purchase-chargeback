//
//  ChargebackWireframe.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/1/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class ChargebackWireframe: AppPageWireframe {
    
    weak var rootViewController: UIViewController?
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    static func launchModule(rawPage: [String: AnyObject], fromViewController: UIViewController) {
        let page = ChargebackPage(raw: rawPage)
        
        let api = AppServerAPI()
        let chargebackView = ChargebackViewController()
        let modal = UICustomModalViewController()
        let wireframe = ChargebackWireframe(rootViewController: fromViewController)
        let presenter = ChargebackPresenter(wireframe: wireframe, userInterface: chargebackView, api: api)
        
        chargebackView.eventHandler = presenter
        modal.installContentViewController(chargebackView)
        
        fromViewController.present(modal, animated: true, completion: nil)
        chargebackView.presentPage(page)
    }
}

// MARK: - ChargebackWireframeProtocol
extension ChargebackWireframe: ChargebackWireframeProtocol {
    
}
