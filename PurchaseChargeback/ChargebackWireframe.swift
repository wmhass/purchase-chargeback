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
        let wireframe = ChargebackWireframe(rootViewController: modal)
        let presenter = ChargebackPresenter(wireframe: wireframe, userInterface: chargebackView, api: api)
        
        chargebackView.eventHandler = presenter
        modal.installContentViewController(chargebackView)
        
        fromViewController.present(modal, animated: true, completion: nil)
        chargebackView.presentPage(page)
    }
}

// MARK: - ChargebackWireframeProtocol
extension ChargebackWireframe: ChargebackWireframeProtocol {
    
    func chargebackDone() {
        guard let presentingView = rootViewController?.presentingViewController else {
            return
        }
        self.rootViewController?.dismiss(animated: true) {
            
            let title = "Contestação de compra recebida"
            let message = "<center><p>Fique de olho no seu email! Nos próximos 3 dias você deverá receber um primeiro retorno sobre sua contestação</p></center>"
            let actions = [
                NoticePage.Action(title: "notice.action.close".localized(comment: "Fechar"), type: NoticePage.Action.ActionType.cancel)
            ]
            let page = NoticePage(title: title, htmlMessage: message, actions: actions)
            
            NoticeWireframe.launchModule(noticePage: page, fromViewController: presentingView)
        }
    }
    
    func chargebackCanceled() {
        self.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
