//
//  NoticeWireframe.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class NoticeWireframe: AppPageWireframe {
    
    
    weak var rootViewController: UIViewController?
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    static func launchModally(rawPage: [String: AnyObject], fromViewController: UIViewController) {
        let noticePage = NoticePage(raw: rawPage)
        let noticeViewController = NoticeViewController()
        let modal = UICustomModalViewController()
        
        let wireframe = NoticeWireframe(rootViewController: modal)
        let presenter = NoticePresenter(wireframe: wireframe, userInterface: noticeViewController)
        
        noticeViewController.eventHandler = presenter
        noticeViewController.presentPage(noticePage)
        modal.installContentViewController(noticeViewController)
        
        fromViewController.present(modal, animated: true, completion: nil)
    }
    
}
