//
//  ReasonDetail.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/2/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import Foundation

struct ReasonDetail {
    var id: String?
    var title: String?
    var response: Bool = false
}

extension ReasonDetail {
    enum Field: String {
        case title, id, response
    }
    init(raw: [String: AnyObject]) {
        self.id = raw[ReasonDetail.Field.id.rawValue] as? String
        self.title = raw[ReasonDetail.Field.title.rawValue] as? String
    }
    
    var encodePage: [String: AnyObject] {
        return [
            ReasonDetail.Field.id.rawValue: self.id as AnyObject? ?? "" as AnyObject,
            ReasonDetail.Field.response.rawValue: self.response as AnyObject? ?? false as AnyObject
        ]
    }
}
