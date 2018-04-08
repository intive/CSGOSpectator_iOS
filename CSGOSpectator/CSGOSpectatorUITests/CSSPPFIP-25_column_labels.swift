//
//  CSSPPFIP-25_column_labels.swift
//  CSGOSpectatorUITests
//
//  Created by user on 08/04/2018.
//  Copyright © 2018 intive. All rights reserved.
//

import XCTest

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
    
    func testExample() {
//        Scenario background:
//        Given I have Internet connection
//        And I run the app
//        And There's connection with the server
//
//        Scenario outline: Basic flow - column labels
//        When the match is on
//        Then <"column_label"> should be displayed
//        And it should be specifically ordered from left to right being column_label with <"number"> 1 a first one
//
//       Examples:
//        | column_label | number |
//        | killsLabel   | 1      |
//        | deathsLabel  | 2      |
//        | assistsLabel | 3      |
//        | mvpLabel     | 4      |
//        | scoreLabel   | 5      |
        
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts["killsLabel"].exists)
        XCTAssertTrue(app.staticTexts["deathsLabel"].exists)
        XCTAssertTrue(app.staticTexts["assistsLabel"].exists)
        XCTAssertTrue(app.staticTexts["mvpLabel"].exists)
        XCTAssertTrue(app.staticTexts["scoreLabel"].exists)
    }
}
