//
//  ViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

enum NoticeAction {
    case cancel
    case Continue // Using a capital C because `continue` is a reserved word
}

struct NoticeActionViewModel {
    let action: NoticeAction
    let text: String
}

struct NoticeViewModel {
    
    let title: String
    var description: String
    var actions: [NoticeActionViewModel] = [NoticeActionViewModel]()
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

