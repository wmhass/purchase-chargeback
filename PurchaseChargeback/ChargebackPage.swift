//
//  ChargebackPage.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

struct ChargebackPage {
    
    struct ReasonDetail {
        var id: String?
        var title: String?
        var value: Bool = false
    }
    
    var title: String?
    var links: [String: NSURL] = [:]
    var commentHint: String?
    var id: String?
    var autoBlock: Bool = false
    var reasonDetails: [ReasonDetail] = []
}

extension ChargebackPage {
    
    enum Field: String {
        case comment_hint, id, title, autoblock, reason_details
    }
    init(raw: [String: AnyObject]) {
        
        self.title = raw[ChargebackPage.Field.title.rawValue] as? String
        self.commentHint = raw[ChargebackPage.Field.comment_hint.rawValue] as? String
        self.id = raw[ChargebackPage.Field.id.rawValue] as? String
        
        if let autoBlock = raw[ChargebackPage.Field.autoblock.rawValue] as? Bool {
            self.autoBlock = autoBlock
        }
        
        /*if let links = raw[AppLink.Field.links.rawValue] as?  [String: [String: AnyObject]] {
            for (linkName, link) in links {
                if let href = link[AppLink.Field.href.rawValue] as? String, let url = NSURL(string: href) {
                    self.links[linkName] = url
                }
            }
        }*/
        
        if let reasonDetails = raw[ChargebackPage.Field.reason_details.rawValue] as? [[String: AnyObject]] {
            self.reasonDetails = reasonDetails.map({ (item: [String : AnyObject]) -> ChargebackPage.ReasonDetail in
                return ChargebackPage.ReasonDetail(raw: item)
            })
        }
        
    }
    
}

extension ChargebackPage.ReasonDetail {
    
    enum Field: String {
        case title, id
    }
    
    init(raw: [String: AnyObject]) {
        self.id = raw[ChargebackPage.ReasonDetail.Field.id.rawValue] as? String
        self.title = raw[ChargebackPage.Field.title.rawValue] as? String
    }
}
