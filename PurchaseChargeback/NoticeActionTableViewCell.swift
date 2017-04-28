//
//  NoticeActionTableViewCell.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class NoticeActionTableViewCell: UITableViewCell {
    
    enum ActionTitleStyle {
        case primary
        case secondary
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topKeyline: UIView!
    var titleStyle: ActionTitleStyle = .secondary {
        didSet { self.reloadStyle() }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        
        self.selectedBackgroundView = UIView()
        self.titleLabel.font = AppFont.noticeActionTitle
        self.topKeyline.backgroundColor = AppColor.keylineBgd
        self.selectedBackgroundView?.backgroundColor = AppColor.keylineBgd
        
        self.reloadStyle()
    }
    
    func reloadStyle() {
        switch self.titleStyle {
        case .primary:
            self.titleLabel.textColor = AppColor.titlePrimary
        case .secondary:
            self.titleLabel.textColor = AppColor.titleSecondary
        }
    }
}
