//
//  InputViewTests.swift
//  ThreeViewChallengeTests
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import XCTest
@testable import ThreeViewChallenge

class InputViewTests: XCTestCase {

	var sut: InputView!

    override func setUp() {}

    override func tearDown() {
        sut = nil
    }

    func test_inputview_noValueAtStart() {
		sut = InputView(orderNumber: "", toolBarView: UIView())

		XCTAssertNil(sut.getNewValue())
    }

	func test_inputview_returnsGivenValue() {
		sut = InputView(orderNumber: "", toolBarView: UIView())

		sut.setTextFieldValue(20)
		XCTAssert(sut.getNewValue() == 20)

		sut.setTextFieldValue(nil)
		XCTAssertNil(sut.getNewValue())
    }
}
