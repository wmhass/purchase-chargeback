//
//  ChargebackViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class ChargebackViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var reasonsDetailsTableVew: UITableView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var keylines: [UIView]!
    @IBOutlet var reasonTextView: AttributedPlaceholderTextView!
    @IBOutlet var continueButton: UIButton!
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.overlayBackground
        
        self.reasonsDetailsTableVew.register(ChargebackReasonDetailTableViewCell.nib, forCellReuseIdentifier: ChargebackReasonDetailTableViewCell.defaultReuseIdentifier)
        
        self.setupFooterButtons()
        self.themeKeylines()

        self.titleLabel.font = AppFont.chargebackTitle
        self.titleLabel.text = "chargeback.title.donotrecognize".localized(comment: "NÃO RECONHECO ESSA COMPRA")
        
        
        self.reasonTextView.text = nil

        let placeholderText = "Nos conte <strong>em detalhes</strong> o que aconteceu com a sua compra em Transaction...".css(style: AppColor.chargebackTextViewStylesheet)
        self.reasonTextView.attributedPlaceholder = NSAttributedString(html: placeholderText)
    }
    
    fileprivate func themeKeylines() {
        for keylineView in self.keylines {
            keylineView.backgroundColor = AppColor.keylineBgd
        }
    }
    
    fileprivate func setupFooterButtons() {
        self.cancelButton.setTitle("chargeback.button.cancelar".localized(comment: "CANCELAR"), for: UIControlState.normal)
        self.continueButton.setTitle("chargeback.button.contestar".localized(comment: "CONTESTAR"), for: UIControlState.normal)
        
        self.cancelButton.titleLabel?.font = AppFont.chargebackFooterButton
        self.continueButton.titleLabel?.font = AppFont.chargebackFooterButton
        
        self.cancelButton.setTitleColor(AppColor.titleSecondary, for: .normal)
        self.continueButton.setTitleColor(AppColor.titleSecondaryDisabled, for: .normal)
    }

}

// MARK: - UITableViewDataSource
extension ChargebackViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChargebackReasonDetailTableViewCell.defaultReuseIdentifier, for: indexPath) as! ChargebackReasonDetailTableViewCell
        
        return cell
    }
    
}
