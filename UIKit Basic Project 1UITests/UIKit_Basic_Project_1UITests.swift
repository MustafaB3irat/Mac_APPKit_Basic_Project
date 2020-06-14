//
//  UIKit_Basic_Project_1UITests.swift
//  UIKit Basic Project 1UITests
//
//  Created by Asal Macbook 1 on 11/06/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import XCTest

class UIKit_Basic_Project_1UITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        app = nil
    }

    func testUsersTableView() {
        let row = app.tables.firstMatch.staticTexts.firstMatch
        app.launch()
        let ex = expectation(description: "sadsds")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            row.tap()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
           XCTAssert(self.app.otherElements.firstMatch.staticTexts.firstMatch.exists, "haay")
                
                ex.fulfill()
            }
        }
        wait(for: [ex], timeout: 8)

    }

}
