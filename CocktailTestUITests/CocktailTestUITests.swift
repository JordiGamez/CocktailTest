//
//  CocktailTestUITests.swift
//  CocktailTestUITests
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import XCTest

class CocktailTestUITests: XCTestCase {
    
    // MARK: Constants
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testSelectBeerCategory() {
        app.tables.staticTexts["Beer"].tap()
        XCTAssertEqual(app.tables.staticTexts.count, 11)
    }
}
