//
//  AppApiLink.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/1/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation
struct AppApiLink {
    let url: URL
    let name: String
    
    enum Field: String {
        case links, href
    }
    
    static func parseLinks(fromRawPage rawPage: [String: AnyObject]) -> [AppApiLink] {
        var links: [AppApiLink] = []
        if let rawLinks = rawPage[Field.links.rawValue] as?  [String: [String: AnyObject]] {
            for (linkName, link) in rawLinks {
                if let href = link[Field.href.rawValue] as? String, let url = URL(string: href) {
                    links.append(AppApiLink(url: url, name: linkName))
                }
            }
        }
        return links
    }
    
}
