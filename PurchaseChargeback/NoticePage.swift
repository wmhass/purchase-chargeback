//
//  NoticePage.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/29/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation



struct NoticePage {
    
    var descriptionStyleSheet = AppColor.noticeDescriptionStylesheet
    
    struct Action {
        enum ActionType: String {
            case cancel, `continue`
        }
        var title: String?
        var type: Action.ActionType?
    }
    
    var title: String?
    var description: NSAttributedString?
    var links: [String: NSURL] = [:]
    var actions: [NoticePage.Action] = []
    
    init(title: String?, htmlMessage html: String?, actions: [NoticePage.Action]) {
        self.title = title
        self.actions = actions

        if let html = html {
            let styledHtml = html.prependStyleSheet(self.descriptionStyleSheet)
            self.description = NSAttributedString(html: styledHtml)
        }
    }
}

extension NoticePage {
    
    enum Field: String {
        case title, description, primary_action, secondary_action, chargeback
    }
    
    init(raw: [String: AnyObject]) {
        self.title = raw[NoticePage.Field.title.rawValue] as? String
        
        if let description = raw[NoticePage.Field.description.rawValue] as? String {
            if let attrString = NSMutableAttributedString(html: description.prependStyleSheet(self.descriptionStyleSheet)) {
                self.description = attrString
            }
        }
        
        /*if let links = raw[AppLink.Field.links.rawValue] as?  [String: [String: AnyObject]] {
            for (linkName, link) in links {
                if let href = link[AppLink.Field.href.rawValue] as? String, let url = NSURL(string: href) {
                    self.links[linkName] = url
                }
            }
        }*/

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
