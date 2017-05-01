//
//  HomePage.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/1/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

struct HomePage {
    
    var links: [AppApiLink] = []

}

extension HomePage {
    
    init(raw: [String: AnyObject]) {
        self.links.append(contentsOf: AppApiLink.parseLinks(fromRawPage: raw))
    }

}
