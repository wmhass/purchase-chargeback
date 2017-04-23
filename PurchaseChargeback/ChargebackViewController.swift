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
    @IBOutlet var reasonTextView: UITextView!
    @IBOutlet var reasonsDetailsTableVew: UITableView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.overlayBackground
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
