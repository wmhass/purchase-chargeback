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
        let noticeViewController = NoticeViewController()
        
        let modal = UICustomModalViewController()
        modal.installContentViewController(noticeViewController)
        
        self.present(modal, animated: true, completion: nil)
    }
}
