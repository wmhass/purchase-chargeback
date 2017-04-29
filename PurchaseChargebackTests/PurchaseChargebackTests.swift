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
        let generatedCSS = html.css(style: styleSheet)
        
        let expectedCSS = "<style>" + styleSheet + "</style>" + html
        XCTAssertEqual(generatedCSS, expectedCSS)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        let html = "<style>p { color: #ff0000; }</style>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>jash shd uahsdasdhuas d<strong>asdasdasd</strong><p>asd</p>"
        self.measure {
            NSAttributedString(html: html)
        }
    }
    
}
