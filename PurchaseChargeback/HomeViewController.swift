//
//  HomeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBAction func startButtonTouched() {
    
        Alamofire.request("https://nu-mobile-hiring.herokuapp.com/notice", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            
            guard let json = response.result.value as? [String: AnyObject] else {
                // TODO: Notify error
                print("asd")
                return
            }
            
            let page = NoticePage(raw: json)
            let noticeViewController = NoticeViewController()
            noticeViewController.presentPage(page: page)
            
            let modal = UICustomModalViewController()
            modal.installContentViewController(noticeViewController)
            
            self.present(modal, animated: true, completion: nil)
            
        }
    }
}
