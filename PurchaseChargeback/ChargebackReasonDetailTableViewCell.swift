//
//  ChargebackReasonDetailTableViewCell.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol ChargebackReasonDetailTableViewCellDelegate: class {
    func reasonDetailTableViewCell(cell: ChargebackReasonDetailTableViewCell, didChangeSwitchToValue newValue: Bool)
}

class ChargebackReasonDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchContainer: UIView!
    let customSwitch = UICustomSwitch()
    weak var delegate: ChargebackReasonDetailTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.font = AppFont.chargebackReasonLabel
        
        self.customSwitch.frame = self.switchContainer.bounds
        self.customSwitch.onLabel = "chargeback.reasondetail.on".localized(comment: "sim")
        self.customSwitch.offLabel = "chargeback.reasondetail.off".localized(comment: "não")
        self.customSwitch.onTintColor = AppColor.chargebackReasonOn
        self.customSwitch.valueChanged = { [weak self] _ in
            self?.customSwitchValueChanged()
        }
        
        self.switchContainer.addSubview(customSwitch)
        self.updateLayoutForCurrentSwitchValue()
    }
    
    fileprivate func customSwitchValueChanged() {
        self.delegate?.reasonDetailTableViewCell(cell: self, didChangeSwitchToValue: self.customSwitch.isOn)
        self.updateLayoutForCurrentSwitchValue()
    }
    
    fileprivate func updateLayoutForCurrentSwitchValue() {
        if self.customSwitch.isOn {
            self.titleLabel.textColor = self.customSwitch.onTintColor
        } else {
            self.titleLabel.textColor = AppColor.blackText
        }
    }
    
}

extension ChargebackReasonDetailTableViewCell {
    
    func setup(withReasonDetail reasonDetail: ReasonDetail?) {
        self.titleLabel?.text = reasonDetail?.title
        self.customSwitch.setOn(reasonDetail != nil ? reasonDetail!.response : false, animated: false)
    }
    
}
