//
//  ChargebackPage.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation


struct ChargebackPage {
    typealias LinkName = String
    
    var title: String?
    var links = [LinkName: AppApiLink]()
    var commentHint: NSAttributedString?
    var id: String?
    var autoBlock: Bool = false
    var reasonDetails: [ReasonDetail] = []
    var comment: String?
    var isCardLocked: Bool = false
    
    var lockCardURL: URL? {
        return self.links["unblock_card"]?.url
    }
    var unlockCardURL: URL? {
        return self.links["block_card"]?.url
    }
    
    var isDataValid: Bool {
        guard let comment = self.comment else {
            return false
        }
        return comment.characters.count > 0
    }
    
    var submitURL: URL? {
        return self.links["self"]?.url
    }
}

extension ChargebackPage {
    enum Field: String {
        case comment_hint, id, title, autoblock, reason_details, comment
    }
    init(raw: [String: AnyObject]) {
        AppApiLink.parseLinks(fromRawPage: raw).forEach { self.links[$0.name] = $0 }

        self.title = raw[ChargebackPage.Field.title.rawValue] as? String
        self.id = raw[ChargebackPage.Field.id.rawValue] as? String
        
        if let commentHint = raw[ChargebackPage.Field.comment_hint.rawValue] as? String {
            self.commentHint = NSAttributedString(html: commentHint.prependStyleSheet(AppColor.chargebackDescriptionStylesheet))
        }
        
        if let autoBlock = raw[ChargebackPage.Field.autoblock.rawValue] as? Bool {
            self.autoBlock = autoBlock
        }

        if let reasonDetails = raw[ChargebackPage.Field.reason_details.rawValue] as? [[String: AnyObject]] {
            self.reasonDetails = reasonDetails.map {ReasonDetail(raw: $0)}
        }
    }
    
    var encodePage: [String: AnyObject] {
        let reasonDetails: [[String: AnyObject]] = self.reasonDetails.map { $0.encodePage }
        return [
            ChargebackPage.Field.comment.rawValue: self.comment as AnyObject? ?? "" as AnyObject,
            ChargebackPage.Field.reason_details.rawValue: reasonDetails as AnyObject
        ]
    }
    
}
