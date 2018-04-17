//
//  CSGOSpectatorUITests.swift
//  CSGOSpectatorUITests
//
//  Created by Mateusz Fidos on 03.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import XCTest
let app = XCUIApplication()
class CSSPPFIP25: XCTestCase {
        
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
    
    func testDeathsLabel() {
        XCTContext.runActivity(named: "Checking if Deaths Column Label is displayed") { _ in XCTAssertTrue(app.staticTexts["D"].exists)}
    }
    func testKillsLabel() {
         XCTContext.runActivity(named: "Checking if Kills Column Label is displayed") { _ in
            XCTAssertTrue(app.staticTexts["Kikuhjsfjsfg"].exists)}
    }
    func testMVPLabel() {
        XCTContext.runActivity(named: "Checking if MVP Column Label is displayed") { _ in
            XCTAssertTrue(app.staticTexts["MVP"].exists)}
    }
    func testAssistsLabel() {
        XCTContext.runActivity(named: "Checking if Assists Column Label is displayed") { _ in
            XCTAssertTrue(app.staticTexts["A"].exists)}
    }
    func testScoreLabel() {
        XCTContext.runActivity(named: "Checking if Score Column Label is displayed") { _ in
            XCTAssertTrue(app.staticTexts["SCORE"].exists)}
    }
}
