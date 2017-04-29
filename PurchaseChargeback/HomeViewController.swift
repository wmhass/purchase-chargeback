//
//  HomeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBAction func startButtonTouched() {
        let html = "<p>Estamos com você nesta! Certifique-se dos pontos abaixo, são muito importantes:<br/><strong>• Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font>. Diversas vezes encontramos informações valiosas por lá e elas podem te ajudar neste processo.</strong><br/><strong>• Caso você reconheça a compra, é muito importante pra nós que entre em contato com o estabelecimento e certifique-se que a situação já não foi resolvida.</strong></p>"
        
        let actions = [
            NoticePage.Action(title: "notice.action.continue".localized(comment: "CONTINUAR"), type: NoticePage.Action.ActionType.continue),
            NoticePage.Action(title: "notice.action.close".localized(comment: "FECHAR"), type: NoticePage.Action.ActionType.cancel)
        ]
        
        let title = "notice.title.beforecontinue".localized(comment: "Antes de continuar")
        
        let page = NoticePage(title: title, description: html, links: [:], actions: actions)
        
        let noticeViewController = NoticeViewController()
        noticeViewController.presentPage(page: page)
        
        let modal = UICustomModalViewController()
        modal.installContentViewController(noticeViewController)
        
        self.present(modal, animated: true, completion: nil)
    }
}
