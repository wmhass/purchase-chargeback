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
    func uiFinishedLoading()
}

class HomeViewController: UIViewController {
    
    var evenHandler: HomeUIEventHandler?
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.evenHandler?.uiFinishedLoading()
    }
    
    @IBAction func startButtonTouched() {
        self.evenHandler?.beginChargebackFlow()
    }
}

// MARK: - HomeUserInterface
extension HomeViewController: HomeUserInterface {
    
    func showErrorMessage(_ message: String?) {
        self.handleErrorMessage(message)
    }
    
    func refresh(withPage page: HomePage) {
        
    }
    
    func showLoadingContentState(_ shouldShow: Bool) {
        
    }
    
}
