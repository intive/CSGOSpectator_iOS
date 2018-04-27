//
//  Live_&Settings_&History_Buttons.swift
//  CSGOSpectatorUITests
//
//  Created by Magdalena Jędraszak on 18.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import XCTest
let tabBarsQuery = XCUIApplication().tabBars
class LiveSettingsHistoryButtons: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHistoryButtonVisibility() {
        XCTContext.runActivity(named: "Checking if History Button is displayed") { _ in
            XCTAssertTrue(tabBarsQuery.buttons["History"].exists)}
    }
    func testHistoryButtonClickability() {
        XCTContext.runActivity(named: "Checking if History Button will take me to History View") { _ in
            tabBarsQuery.buttons["History"].tap()
            XCTAssertFalse(tabBarsQuery.buttons["MVP"].exists)}
    }
    func testSettingsButtonVisibility() {
        XCTContext.runActivity(named: "Checking if Settings Button is displayed") { _ in
            XCTAssertTrue(tabBarsQuery.buttons["Settings"].exists)}
    }
    func testSettingsButtonClickability() {
        XCTContext.runActivity(named: "Checking if Settings Button will take me to Settings View") { _ in
            tabBarsQuery.buttons["Settings"].tap()
            XCTAssertFalse(tabBarsQuery.buttons["MVP"].exists)}
    }
    func testLiveButtonVisibility() {
        XCTContext.runActivity(named: "Checking if Live Button is displayed") { _ in
            XCTAssertTrue(tabBarsQuery.buttons["Live"].exists)}
    }
    func testLiveButtonClickability() {
        XCTContext.runActivity(named: "Checking if Live Button will take me from Settings View to Live View") { _ in
            tabBarsQuery.buttons["Settings"].tap()
            XCTAssertFalse(tabBarsQuery.buttons["MVP"].exists)
            tabBarsQuery.buttons["Live"].tap()
            XCTAssertFalse(tabBarsQuery.buttons["MVP"].exists)
        }
    }
}
