//
//  AppServerAPIStub.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/5/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import XCTest
@testable import PurchaseChargeback

class AppServerAPIStub {
    var routeLinkExpectation: XCTestExpectation?
}

// MARK: - AppServerAPIProtocol
extension AppServerAPIStub: AppServerAPIProtocol {
    func post(url: URL, object: [String: AnyObject]?, completion: AppServerAPIProtocol.RequestCompletion?) {
    }
    
    func get(url: URL, completion: AppServerAPIProtocol.RequestCompletion?) {

    }
    
    func routeLink(appLink: AppApiLink, completion: @escaping (_ result: RouterResult) -> Void) {
        self.routeLinkExpectation?.fulfill()
    }
}
