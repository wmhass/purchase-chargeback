//
//  AppDelegate.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.autoresizingMask = [UIViewAutoresizing.flexibleWidth, .flexibleHeight]
        
        let homeViewController = HomeViewController()
        homeViewController.view.frame = window.bounds
        window.rootViewController = homeViewController
        window.addSubview(homeViewController.view)
        
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}

