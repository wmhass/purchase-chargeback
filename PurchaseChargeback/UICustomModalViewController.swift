//
//  UICustomModalViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/28/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class UICustomModalViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    weak var contentViewController: UIViewController?
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.overlayBackground
        
        if let contentViewController = self.contentViewController {
            self.addChildViewController(contentViewController)
            contentViewController.view.frame = self.contentView.bounds
            contentViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentViewController.view.translatesAutoresizingMaskIntoConstraints = true
            
            self.contentView.addSubview(contentViewController.view)
            
            contentViewController.didMove(toParentViewController: self)
        }
    }

    func installContentViewController(_ contentViewController: UIViewController) {
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalPresentationCapturesStatusBarAppearance = true
        
        self.contentViewController = contentViewController
    }
    
}
