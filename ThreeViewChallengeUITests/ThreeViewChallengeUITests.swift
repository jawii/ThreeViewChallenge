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
		app.launch()
    }

    override func tearDown() {
		app = nil
    }

	func test_ui_startsFromFirstInputView() {
		XCTAssertTrue(app.isDisplayingFirstScreen)
	}

	func test_ui_continuesSameView_whenPaused() {
		// Activating takes some time so do the waiting

		XCUIDevice.shared.press(.home)
		XCUIApplication().activate()
		XCTAssertTrue(app.waitForElementToAppear(app.firstScreen))

		app.tabBars.buttons["Input 2"].tap()
		XCUIDevice.shared.press(.home)
		XCUIApplication().activate()
		XCTAssertTrue(app.waitForElementToAppear(app.secondScreen))

		app.tabBars.buttons["Result"].tap()
		XCUIDevice.shared.press(.home)
		XCUIApplication().activate()
		XCTAssertTrue(app.waitForElementToAppear(app.resultScreen))
	}

	func test_simpleInput() {
		app.setInputFieldValues(values: ["2", "3"])
		app.tabBars.buttons["Result"].tap()
		XCTAssertTrue(app.staticTexts["2.0 × 3.0 = 6.0"].exists)
	}

	func test_input_change() {
		// Go first screen and provide values
		app.setInputFieldValues(values: ["1", "1"])

		// Go second screen and provide values
		app.tabBars.buttons["Input 2"].tap()
		app.setInputFieldValues(values: ["2", "3"])

		// Check result page
		app.tabBars.buttons["Result"].tap()
		XCTAssertTrue(app.staticTexts["2.0 × 3.0 = 6.0"].exists)
	}

	func test_lastEdited_change() {
		// Go first screen and provide values
		app.setInputFieldValues(values: ["2", "3"])

		// Go second screen and provide values
		app.tabBars.buttons["Input 2"].tap()
		app.setInputFieldValues(values: ["8", "7"])

		// Go first screen and touch values
		app.tabBars.buttons["Input 1"].tap()
		app.firstInputTextField.tap()
		app.staticTexts["Confirm"].forceTapElement()

		// Check result page
		app.tabBars.buttons["Result"].tap()
		XCTAssertTrue(app.staticTexts["2.0 × 3.0 = 6.0"].exists)
	}

	func test_ui_incompletevalues() {
		app.firstInputTextField.tap()
		app.keys["3"].tap()
		app.staticTexts["Confirm"].forceTapElement()

		app.tabBars.buttons["Result"].tap()
		XCTAssertTrue(app.staticTexts["Incomplete values."].exists)
	}

	func test_ui_valuesNotProvided() {
		app.tabBars.buttons["Result"].tap()
		XCTAssertTrue(app.staticTexts["No Inputs Provided."].exists)
	}
}

extension XCUIApplication {

	var firstScreen: XCUIElement { return otherElements["input 1"] }
	var secondScreen: XCUIElement { return otherElements["input 2"] }
	var resultScreen: XCUIElement { return otherElements["result view"] }

    var isDisplayingFirstScreen: Bool { return firstScreen.exists }
	var isDisplayingSecondScreen: Bool { return secondScreen.exists }
	var isDisplayingResultScreen: Bool { return resultScreen.exists }

	func waitForElementToAppear(_ element: XCUIElement) -> Bool {
		let predicate = NSPredicate(format: "exists == true")
		let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
		let result = XCTWaiter().wait(for: [expectation], timeout: 5)
		return result == .completed
	}

	var firstInputTextField: XCUIElement { return textFields["textfield 1"] }
	var secondInputTextField: XCUIElement { return textFields["textfield 2"] }

	func setInputFieldValues(values: [String]) {
		firstInputTextField.tap()
		keys[values[0]].tap()
		staticTexts["Confirm"].forceTapElement()

		secondInputTextField.tap()
        keys[values[1]].tap()
		staticTexts["Confirm"].forceTapElement()
	}
}

extension XCUIElement {
	// Ensure that hit happens.
	// Use for cases when element.isHittable is false
    func forceTapElement() {
		if self.isHittable {
            self.tap()
		} else {
			let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
            coordinate.tap()
        }
    }
}
