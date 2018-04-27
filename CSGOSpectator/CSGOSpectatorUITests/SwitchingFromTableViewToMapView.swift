//
//  SwitchingFromTableViewToMapView.swift
//  CSGOSpectatorUITests
//
//  Created by Magdalena Jędraszak on 18.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import XCTest

class SwitchingFromTableViewToMapView: XCTestCase {
        
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
    
    func testSwitchFromTableToMap() {
        XCTContext.runActivity(named: "Checking if user can switch from Table view to the Map view") { _ in
        app.pageIndicators["page 1 of 2"].tap()
        XCTAssertTrue(app.staticTexts["map"].exists)}
    }
    func testSwitchFromMapToTable() {
        XCTContext.runActivity(named: "Checking if user can switch from Map view to the Table view") { _ in
        app.pageIndicators["page 1 of 2"].tap()
        app.pageIndicators["page 2 of 2"].tap()
        XCTAssertTrue(app.staticTexts["MVP"].exists)}
    }
    }

