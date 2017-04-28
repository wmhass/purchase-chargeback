//
//  NoticeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit
import WebKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var actionsTableView: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupActionsTableView()
        
        self.view.backgroundColor = AppColor.overlayBackground
        self.titleLabel.font = AppFont.noticeTitle
        self.titleLabel.textColor = AppColor.titlePrimary

        self.titleLabel.text = "notice.title.beforecontinue".localized(comment: "Antes de continuar")
        let html = "<p>Estamos com você nesta! Certifique-se dos pontos abaixo, são muito importantes:<br/><strong>• Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font>. Diversas vezes encontramos informações valiosas por lá e elas podem te ajudar neste processo.</strong><br/><strong>• Caso você reconheça a compra, é muito importante pra nós que entre em contato com o estabelecimento e certifique-se que a situação já não foi resolvida.</strong></p>".css(style: AppColor.chargebackTextViewStylesheet)
        
        self.descriptionTextView.attributedText = NSAttributedString(html: html)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupActionsTableView() {
        self.actionsTableView.rowHeight = 77
        self.actionsTableView.tableFooterView = UIView()
        self.actionsTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.actionsTableView.register(NoticeActionTableViewCell.nib, forCellReuseIdentifier: NoticeActionTableViewCell.defaultReuseIdentifier)
    }
    
}

// MARK: - UITableViewDataSource
extension NoticeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeActionTableViewCell.defaultReuseIdentifier, for: indexPath) as! NoticeActionTableViewCell
        
        if indexPath.row == 0 {
            cell.titleLabel.text = "notice.action.continue".localized(comment: "CONTINUAR")
            cell.titleStyle = .primary
        } else {
            cell.titleLabel.text = "notice.action.close".localized(comment: "FECHAR")
            cell.titleStyle = .secondary
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension NoticeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 0 {
            let presentingView = self.presentingViewController
            self.dismiss(animated: true, completion: {
                let chargebackViewController = ChargebackViewController()
                chargebackViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                chargebackViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                chargebackViewController.modalPresentationCapturesStatusBarAppearance = true
                
                presentingView?.present(chargebackViewController, animated: true, completion: nil)
            })
            
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
