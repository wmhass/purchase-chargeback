//
//  HomeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol HomeUIEventHandler {
    func beginChargebackFlow()
}

class HomeViewController: UIViewController, HomeUserInterface {
    
    var evenHandler: HomeUIEventHandler?
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBAction func startButtonTouched() {
        self.evenHandler?.beginChargebackFlow()
    }
}
