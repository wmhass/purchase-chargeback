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
    
    static func launchModule(rawPage: [String: AnyObject], fromViewController: UIViewController) {
        let noticePage = NoticePage(raw: rawPage)
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
    
}

// MARK: - NoticeWireframeProtocol
extension NoticeWireframe: NoticeWireframeProtocol {
    
    func continueActionTapped(page: NoticePage, completion: @escaping () -> Void) {
        guard let viewController = self.rootViewController, let url = page.link(withName: self.continueActionLinkName) else {
            return
        }
        AppRouter.routePage(ofType: AppPageType.chargeback, fromURL: url, fromViewController: viewController) { [weak self] (result: RouterResult) in
            completion()
            switch result {
            case .success(let pagewireframe, let rawPage):
                
                let presentingView = self?.rootViewController?.presentingViewController
                self?.dismiss(completion: {
                    if let presentingView = presentingView {
                        pagewireframe.launchModule(rawPage: rawPage, fromViewController: presentingView)
                    }
                })
                
            case .error(let error):
                self?.rootViewController?.handleErrorMessage(error)
            }
        }
    }
    
    func dismiss(completion: (() -> Void)?) {
        self.rootViewController?.dismiss(animated: true, completion: {
            completion?()
        })
    }
}
