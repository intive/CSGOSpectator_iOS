//
//  checkingHeaderElements.swift
//  CSGOSpectatorUITests
//
//  Created by Magdalena Jędraszak on 18.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import XCTest

class CheckingHeaderElements: XCTestCase {
        
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
    
    func testTerroristIconVisibility() {
        XCTContext.runActivity(named: "Checking if Terrorists Icon is visible") { _ in
            XCTAssertTrue(app.staticTexts["tIcon"].exists)}
    }
    func testAntiterroristIconVisibility() {
        XCTContext.runActivity(named: "Checking if Antiterrorists Icon is visible") { _ in
            XCTAssertTrue(app.staticTexts["antitIcon"].exists)}
    }
    func testTimeRemainValueVisibility() {
        XCTContext.runActivity(named: "Checking if Time Remain cell is visible") { _ in
            XCTAssertTrue(app.staticTexts["timeRemain"].exists)}
    }
    func testWhatScoreVisibility() {
        XCTContext.runActivity(named: "Checking if the score cell is visible") { _ in
            XCTAssertTrue(app.staticTexts["whatScore"].exists)}
    }
    func testWhichRoundVisibility() {
        XCTContext.runActivity(named: "Checking if whichRound cell is visible") { _ in
            XCTAssertTrue(app.staticTexts["whichRound"].exists)}
    }
    
}
