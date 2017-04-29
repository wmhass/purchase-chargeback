//
//  NoticePage.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

enum LinkField: String {
    case links, href
}

struct NoticePage {
    
    struct Action {
        enum ActionType: String {
            case cancel, `continue`
        }
        var title: String?
        var type: Action.ActionType?
    }
    
    var title: String?
    var description: String?
    var links: [String: NSURL] = [:]
    var primaryAction: NoticePage.Action?
    var secondaryAction: NoticePage.Action?
    
}



extension NoticePage {
    
    enum Field: String {
        case title, description, primary_action, secondary_action, chargeback
    }
    
    init(raw: [String: AnyObject]) {
        self.title = raw[NoticePage.Field.title.rawValue] as? String
        self.description = raw[NoticePage.Field.description.rawValue] as? String
        
        if let links = raw[LinkField.links.rawValue] as?  [String: [String: AnyObject]] {
            for (linkName, link) in links {
                if let href = link[LinkField.href.rawValue] as? String, let url = NSURL(string: href) {
                    self.links[linkName] = url
                }
            }
        }
    }
    
}

extension NoticePage.Action {
    
    enum Field: String {
        case title, action
    }
    
    init?(raw: [String: String]?) {
        guard let raw = raw else {
            return nil
        }
        self.title = raw[NoticePage.Action.Field.title.rawValue]
        if let action = raw[NoticePage.Action.Field.action.rawValue] {
            self.type = ActionType(rawValue: action)
        }
    }
}
