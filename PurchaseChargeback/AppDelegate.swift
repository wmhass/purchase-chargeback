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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, .flexibleHeight]
        
        let homeViewController = HomeViewController()
        homeViewController.view.frame = self.window!.bounds
        self.window!.rootViewController = homeViewController
        self.window!.addSubview(homeViewController.view)
        
        self.window!.makeKeyAndVisible()
        
        return true
    }
}

