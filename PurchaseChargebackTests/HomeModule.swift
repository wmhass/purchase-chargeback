//
//  HomeModule.swift
//  PurchaseChargeback
//
//  Created by William Hass on 5/5/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import XCTest
@testable import PurchaseChargeback

class HomeModule: XCTestCase {
    
    class StubPageWireframe: AppPageWireframe {
        static func launchModule(rawPage: [String: AnyObject], fromViewController: UIViewController) {}
    }
    
    class StubWireframe: HomeViewWireframeProtocol {
        weak var launchExpectation: XCTestExpectation?
        func launch(wireframeOfType: AppPageWireframe.Type, withPage rawPage: [String: AnyObject]) {
            self.launchExpectation?.fulfill()
        }
    }
    
    class StubHomeUI: HomeUserInterface {
        weak var showErrorMessageExpecation: XCTestExpectation?
        weak var refreshPageExpecation: XCTestExpectation?
        weak var showLoadingStateExpecation: XCTestExpectation?
        weak var hideLoadingStateExpecation: XCTestExpectation?
        weak var showEmptyStateExpecation: XCTestExpectation?
        weak var hideEmptyStateExpecation: XCTestExpectation?
        
        func showErrorMessage(_ message: String?) { self.showErrorMessageExpecation?.fulfill() }
        func refresh(withPage page: HomePage) { self.refreshPageExpecation?.fulfill() }
        func showLoadingContentState(_ shouldShow: Bool) {
            if shouldShow {
                self.showLoadingStateExpecation?.fulfill()
            } else {
                self.hideLoadingStateExpecation?.fulfill()
            }
        }
        func showEmptyState(_ shouldShow: Bool) {
            if shouldShow {
                self.showEmptyStateExpecation?.fulfill()
            } else {
                self.hideEmptyStateExpecation?.fulfill()
            }
        }
    }
    
    var presenter: HomePresenter!
    var stubAPI = AppServerAPIStub()
    let stubUI = StubHomeUI()
    let stubWireframe = StubWireframe()
    
    override func setUp() {
        super.setUp()
        self.presenter = HomePresenter(wireframe: self.stubWireframe, userInterface: self.stubUI, api: self.stubAPI)
    }
    
    func testGetPageContent() {
        let getFromAPIExpectation = self.expectation(description: "Should GET the cotnent")
        self.stubAPI.getContentExpectation = getFromAPIExpectation
        
        self.presenter.loadPageContent()
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadingState() {
        let showLoadingStateExpectaction = self.expectation(description: "Show Load page content")
        self.stubUI.showLoadingStateExpecation = showLoadingStateExpectaction
        
        let hideLoadingStateExpectation = self.expectation(description: "Hide load page content")
        self.stubUI.hideLoadingStateExpecation = hideLoadingStateExpectation
        
        self.presenter.loadPageContent()
        self.presenter.apiLoadedContent(result: AppServerAPIResponse.success([:]))
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadContentSuccess() {
        let pageRefreshExpectation = self.expectation(description: "Load content success")
        self.stubUI.refreshPageExpecation = pageRefreshExpectation
        
        self.presenter.apiLoadedContent(result: AppServerAPIResponse.success([:]))
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadContentFailed() {
        let showErrorMessageExpectation = self.expectation(description: "Show error message")
        self.stubUI.showErrorMessageExpecation = showErrorMessageExpectation
        
        self.presenter.apiLoadedContent(result: AppServerAPIResponse.failed("Error"))
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLinkSelection() {
        let showLoadingStateExpectaction = self.expectation(description: "Show Load page content")
        self.stubUI.showLoadingStateExpecation = showLoadingStateExpectaction
        
        let askApiRouteLinkExpectation = self.expectation(description: "API Route link")
        self.stubAPI.routeLinkExpectation = askApiRouteLinkExpectation
        
        let link = AppApiLink(url: URL(string: "/")!, name: "Blah")
        
        self.presenter.didSelectLink(link)
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLinkRouteSuccess() {
        let launchPageExpectation = self.expectation(description: "Launch page")
        self.stubWireframe.launchExpectation = launchPageExpectation
        
        self.presenter.apiRoutedLink(result: RouterResult.success(wireframeType: StubPageWireframe.self, rawPage: [:]))
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLinkRouteFailed() {
        let showErrorMessageExpectation = self.expectation(description: "Show error message")
        self.stubUI.showErrorMessageExpecation = showErrorMessageExpectation
        
        self.presenter.apiRoutedLink(result: RouterResult.error("error"))
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
}
