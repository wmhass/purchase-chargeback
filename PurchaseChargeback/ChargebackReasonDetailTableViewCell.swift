//
//  ChargebackReasonDetailTableViewCell.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class ChargebackReasonDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let customSwitch = UICustomSwitch(frame: CGRect(x: 0, y: 0, width: 60, height:20))
        self.addSubview(customSwitch)
    }
}
