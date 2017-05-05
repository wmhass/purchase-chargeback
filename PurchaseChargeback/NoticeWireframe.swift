//
//  NoticeWireframe.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class NoticeWireframe: AppPageWireframe {
    
    let continueActionLinkName = "chargeback"
    
    weak var rootViewController: UIViewController?
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    static func launchModule(noticePage: NoticePage, fromViewController: UIViewController) {
        let noticeViewController = NoticeViewController()
        let modal = UICustomModalViewController()
        let api = AppServerAPI()
        
        let wireframe = NoticeWireframe(rootViewController: modal)
        let presenter = NoticePresenter(wireframe: wireframe, userInterface: noticeViewController, api: api)
        
        noticeViewController.eventHandler = presenter
        noticeViewController.presentPage(noticePage)
        modal.installContentViewController(noticeViewController)
        
        fromViewController.present(modal, animated: true, completion: nil)
    }
    
    static func launchModule(rawPage: [String: AnyObject], fromViewController: UIViewController) {
        let noticePage = NoticePage(raw: rawPage)
        self.launchModule(noticePage: noticePage, fromViewController: fromViewController)
    }
    
}

// MARK: - NoticeWireframeProtocol
extension NoticeWireframe: NoticeWireframeProtocol {
    
    func launch(wireframeOfType: AppPageWireframe.Type, withPage rawPage: [String: AnyObject]) {
        guard let presentingView = rootViewController?.presentingViewController else {
            return
        }
        self.dismiss {
            wireframeOfType.launchModule(rawPage: rawPage, fromViewController: presentingView)
        }
    }
    
    func dismiss(completion: (() -> Void)?) {
        self.rootViewController?.dismiss(animated: true) {
            completion?()
        }
    }
}
