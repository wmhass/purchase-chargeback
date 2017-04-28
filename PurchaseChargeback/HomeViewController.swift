//
//  HomeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func startButtonTouched() {
        let noticeViewController = NoticeViewController()
        
        let modal = UICustomModalViewController()
        modal.installContentViewController(noticeViewController)
        
        self.present(modal, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
