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
    @IBOutlet var keylineHeightConstraints: [NSLayoutConstraint]!
    @IBOutlet var keylines: [UIView]!
    @IBOutlet var reasonTextView: UITextView!
    @IBOutlet var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.overlayBackground
        
        self.reasonsDetailsTableVew.register(ChargebackReasonDetailTableViewCell.nib, forCellReuseIdentifier: ChargebackReasonDetailTableViewCell.defaultReuseIdentifier)
        
        for keylineHeightConstraint in self.keylineHeightConstraints {
            keylineHeightConstraint.constant = 1
        }
        
        for keylineView in self.keylines {
            keylineView.backgroundColor = AppColor.keylineBgd
        }
        
        self.titleLabel.font = AppFont.chargebackTitle
        self.titleLabel.text = "chargeback.title.donotrecognize".localized(comment: "NÃO RECONHECO ESSA COMPRA")
        
        self.reasonTextView.text = nil
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
