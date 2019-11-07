//
//  ThreeViewChallengeUITests.swift
//  ThreeViewChallengeUITests
//
//  Created by Jaakko Kenttä on 7.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import XCTest

class ThreeViewChallengeUITests: XCTestCase {

	var app: XCUIApplication!

    override func setUp() {
		app = XCUIApplication()
        continueAfterFailure = false
		app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
		app = nil
    }

	func test_ui_startsFromFirstInputView() {
		app.launch()
		XCTAssertTrue(app.isDisplayingFirstScreen)
	}

	func test_ui_continuesSameView_whenPaused() {
		app.launch()

		XCUIDevice.shared.press(.home)
		XCUIApplication().activate()
		XCTAssertTrue(app.isDisplayingFirstScreen)

		app.tabBars.buttons["Input 2"].tap()
		XCUIDevice.shared.press(.home)
		XCUIApplication().activate()
		XCTAssertTrue(app.isDisplayingSecondScreen)

		app.tabBars.buttons["Result"].tap()
		XCUIDevice.shared.press(.home)
		XCUIApplication().activate()
		XCTAssertTrue(app.isDisplayingResultScreen)
	}

	func test_simpleInput() {
		app.launch()

		let firstTextField = app.firstInputTextField
		let secondTextField = app.secondInputTextField

		firstTextField.tap()
		app.keys["2"].tap()
		app.staticTexts["Confirm"].tap()

		secondTextField.tap()
        app.keys["3"].tap()
		app.staticTexts["Confirm"].tap()

		app.tabBars.buttons["Result"].tap()

		XCTAssertTrue(app.staticTexts["2.0 × 3.0 = 6.0"].exists)
	}

	func test_input_change() {
		app.launch()

		// Go first screen and provide values
		app.firstInputTextField.tap()
		app.keys["2"].tap()
		app.staticTexts["Confirm"].tap()

		app.secondInputTextField.tap()
        app.keys["3"].tap()
		app.staticTexts["Confirm"].tap()

		// Go second screen and provide values
		app.tabBars.buttons["Input 2"].tap()
		app.firstInputTextField.tap()
		app.keys["1"].tap()
		app.staticTexts["Confirm"].tap()

		app.secondInputTextField.tap()
        app.keys["8"].tap()
		app.staticTexts["Confirm"].tap()

		// Check result page
		app.tabBars.buttons["Result"].tap()
		XCTAssertTrue(app.staticTexts["1.0 × 8.0 = 8.0"].exists)
	}


    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    var isDisplayingFirstScreen: Bool {
        return otherElements["input 1"].exists
    }

	var isDisplayingSecondScreen: Bool {
		return otherElements["input 2"].exists
	}

	var isDisplayingResultScreen: Bool {
		return otherElements["result view"].exists
	}

	var firstInputTextField: XCUIElement {
		return children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).textFields["Tap to set"]
	}

	var secondInputTextField: XCUIElement {
		return children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).textFields["Tap to set"]
	}
}
