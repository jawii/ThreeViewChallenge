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

    func test_inputData_isFresh_whenNoLastEditIndex() {
        sut = InputData(inputs: [], lastEditedIndex: nil)
		XCTAssertTrue(sut.isFresh, "Input data fresh if lastedited index nil ")
    }

	func test_inputData_isEmpty_whenLastEditIndexIsNil() {
		sut = InputData(inputs: [[nil, nil], [2, nil]], lastEditedIndex: nil)
		XCTAssertFalse(sut.isEmpty, "InputData is not empty when lastEditIndex nil")
	}

	func test_inputData_isEmpty_whenNoValues() {
		sut = InputData(inputs: [[nil, nil], [2, nil]], lastEditedIndex: 0)
		XCTAssertTrue(sut.isEmpty, "InputData not empty with no values")
	}

	func test_inputData_isNotEmpty_whenHasValues() {
		sut = InputData(inputs: [[nil, nil], [nil, 4]], lastEditedIndex: 1)
		XCTAssertFalse(sut.isEmpty, "Input data empty with values")
	}

	func test_inputData_completeValues_whenAllValuesGiven() {
		sut = InputData(inputs: [[1, 2], [nil, nil]], lastEditedIndex: 0)
		XCTAssertTrue(sut.hasCompleteData)
	}

	func test_inpuData_noCompleteValues_whenAllValuesNotProvided() {
		sut = InputData(inputs: [[1, 2], [2, nil]], lastEditedIndex: 1)
		XCTAssertFalse(sut.hasCompleteData)
	}

	func test_inpuData_resulsString_withIncompleteValues() {
		sut = InputData(inputs: [[2, 3], [nil, 2]], lastEditedIndex: 1)
		XCTAssertNil(sut.resultString)
	}

	func test_inpuData_resultsNotNil_whenValuesProvided() {
		sut = InputData(inputs: [[nil, nil], [2, 3]], lastEditedIndex: 1)
		XCTAssertNotNil(sut.resultString)
	}

	// TODO: - Add tests for result quantity 
}
