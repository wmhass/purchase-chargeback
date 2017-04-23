//
//  HomeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonTouched(_: AnyObject) {
        
        let noticeViewController = NoticeViewController()
        noticeViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        noticeViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        noticeViewController.modalPresentationCapturesStatusBarAppearance = true
        
        self.present(noticeViewController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
