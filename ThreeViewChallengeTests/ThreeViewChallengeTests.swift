//
//  ThreeViewChallengeTests.swift
//  ThreeViewChallengeTests
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import XCTest

@testable import ThreeViewChallenge

class InputVCTests: XCTestCase {

	var sut: InputVC!

    override func setUp() {
		sut = InputVC.instantiate()
    }

    override func tearDown() {
        sut = nil
    }

    func testcase() {
		XCTAssertNotNil(sut)
    }

	/*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
	*/

}
