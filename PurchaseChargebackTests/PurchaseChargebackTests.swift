//
//  PurchaseChargebackTests.swift
//  PurchaseChargebackTests
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import XCTest
@testable import PurchaseChargeback

class PurchaseChargebackTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCSSString() {
        let html = "<body>blah</body>"
        let styleSheet = "p { color: #ff0000 }"
        let generatedCSS = html.prependStyleSheet(styleSheet)
        
        let expectedCSS = "<style>" + styleSheet + "</style>" + html
        XCTAssertEqual(generatedCSS, expectedCSS)
    }
    
}
