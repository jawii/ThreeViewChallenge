//
//  InputDataTests.swift
//  ThreeViewChallengeTests
//
//  Created by Jaakko Kenttä on 7.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation

import XCTest
@testable import ThreeViewChallenge

class InputDataTests: XCTestCase {

	var sut: InputData!

    override func setUp() {}

    override func tearDown() {
        sut = nil
    }

	private var noInputsProvidedText = "No Inputs Provided."
	private var inCompleteValuesText = "Incomplete values."
	private var hasResult1 = "Calculating result from Input 1"
	private var hasResult2 = "Calculating result from Input 2"

	var statusText: String { return sut.result.statusText.string }
	var resultText: String { return sut.result.resultText.string }

	func test_status_noInput_whenNoLastEditIndex() {
		sut = InputData(inputs: [], lastEditedIndex: nil)
		XCTAssertTrue(statusText == noInputsProvidedText)
	}

	func test_status_noInput_whenNoValues() {
		sut = InputData(inputs: [[nil, nil], [2, nil]], lastEditedIndex: 0)
		XCTAssertTrue(statusText == noInputsProvidedText)
	}

	func test_status_ok_whenAllValuesGiven() {
		sut = InputData(inputs: [[1, 2], [nil, nil]], lastEditedIndex: 0)
		XCTAssertTrue(statusText == hasResult1)
	}

	func test_status_ok_whenAllValuesGiven2() {
		sut = InputData(inputs: [[1, nil], [3, 2]], lastEditedIndex: 1)
		XCTAssertTrue(statusText == hasResult2)
	}

	func test_result_incomplete_whenValuesIncomplete() {
		sut = InputData(inputs: [[nil, nil], [nil, 4]], lastEditedIndex: 1)
		XCTAssertTrue(resultText == inCompleteValuesText)
	}

	func test_result_value1() {
		sut = InputData(inputs: [[2, 3]], lastEditedIndex: 0)
		let value = resultText
		let expectedValue = "2 × 3 = 6"
		XCTAssertTrue(value == expectedValue)
	}

	func test_result_value2() {
		sut = InputData(inputs: [[3, 2.0]], lastEditedIndex: 0)
		let value = resultText
		let expectedValue = "3 × 2 = 6"
		XCTAssertTrue(value == expectedValue)
	}

	func test_result_value3() {
		sut = InputData(inputs: [[3, 2.2]], lastEditedIndex: 0)
		let value = resultText
		let expectedValue = "3 × 2.2 = 6.6"
		XCTAssertTrue(value == expectedValue, "Returned \(value)")
	}

	func test_result_value4() {
		sut = InputData(inputs: [[3.123, 2.23]], lastEditedIndex: 0)
		let value = resultText
		let expectedValue = "3.123 × 2.23 = 6.96429"
		XCTAssertTrue(value == expectedValue, "Returned \(value)")
	}

	func test_negative_value1() {
		sut = InputData(inputs: [[-2, 1]], lastEditedIndex: 0)
		let value = resultText
		let expectedValue = "-2 × 1 = -2"
		XCTAssertTrue(value == expectedValue, "Returned \(value)")
	}

	func test_negative_value2() {
		sut = InputData(inputs: [[2, -3]], lastEditedIndex: 0)
		let value = resultText
		let expectedValue = "2 × (-3) = -6"
		XCTAssertTrue(value == expectedValue, "Returned \(value)")
	}
}
