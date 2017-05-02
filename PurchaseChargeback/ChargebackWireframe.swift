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
        /*let noticePage = NoticePage(raw: rawPage)
        let noticeViewController = NoticeViewController()
        let modal = UICustomModalViewController()
        let api = AppServerAPI()
        
        let wireframe = NoticeWireframe(rootViewController: modal)
        let presenter = NoticePresenter(wireframe: wireframe, userInterface: noticeViewController, api: api)
        
        noticeViewController.eventHandler = presenter
        noticeViewController.presentPage(noticePage)
        modal.installContentViewController(noticeViewController)
        
        fromViewController.present(modal, animated: true, completion: nil)*/
        
        let page = ChargebackPage(raw: rawPage)
        
        let chargebackView = ChargebackViewController()
        let modal = UICustomModalViewController()
        let wireframe = ChargebackWireframe(rootViewController: fromViewController)
        let presenter = ChargebackPresenter(wireframe: wireframe, userInterface: chargebackView)
        
        chargebackView.eventHandler = presenter
        chargebackView.presentPage(page)
        
        modal.installContentViewController(chargebackView)
        
        
        fromViewController.present(modal, animated: true, completion: nil)
    }
}

// MARK: - ChargebackWireframeProtocol
extension ChargebackWireframe: ChargebackWireframeProtocol {
    
}
