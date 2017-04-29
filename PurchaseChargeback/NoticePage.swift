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
    var actions: [NoticePage.Action] = []
    
    func loadHTMLDescription(styleSheet: String?, completion: @escaping ((_ a: NSAttributedString?) -> Void) ) -> Void {
        guard let description = self.description else {
            return completion(nil)
        }
        DispatchQueue.global().async {
            let styledHtml = description.css(style: styleSheet)
            let attributeString = NSAttributedString(html: styledHtml)
            DispatchQueue.main.async {
                completion(attributeString)
            }
        }
    }
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

        if let rawPrimaryAction = raw[NoticePage.Field.primary_action.rawValue] as? [String: String],
            let primaryAction = NoticePage.Action(raw: rawPrimaryAction) {
            self.actions.append(primaryAction)
        }
        
        if let rawSecondaryAction = raw[NoticePage.Field.secondary_action.rawValue] as? [String: String],
            let secondaryAction = NoticePage.Action(raw: rawSecondaryAction) {
            self.actions.append(secondaryAction)
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
