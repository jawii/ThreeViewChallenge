//
//  InputData.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 7.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

typealias InputResult = (statusText: NSAttributedString, resultText: NSAttributedString)

/// Keeps track of user inputted values and which values are last time touched
struct InputData: Codable {

	// MARK: - Properties
	var inputs: [[Double?]]
	var lastEditedIndex: Int?

	// MARK: Computed Properties

	/// Is inputfields touched, ever
	private var isFresh: Bool { return lastEditedIndex == nil }

	/// Check if last entered values has any values
	private var isEmpty: Bool {
		if isFresh { return false }
		return (inputs[lastEditedIndex!].compactMap { $0 }).isEmpty
	}

	// Check if inputs has every value for current input index
	private var hasCompleteData: Bool {
		guard !isFresh && !isEmpty else { return false }

		let values = inputs[lastEditedIndex!]
		return values.count == (values.compactMap {$0}).count
 	}

	private var resultString: NSAttributedString {
		guard !isFresh && !isEmpty && hasCompleteData else {
			return NSAttributedString(string: "Incomplete values.")
		}

		let values = inputs[lastEditedIndex!]

		// Construct String
		let value1Attrs: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.systemTeal ]
		let value1 = NSMutableAttributedString(string: String(values[0]!), attributes: value1Attrs)

		let value2Attrs: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.systemPink ]
		let value2 = NSAttributedString(string: String(values[1]!), attributes: value2Attrs)

		let productMark = NSAttributedString(string: " × ")
		let product = values.compactMap { $0 }.reduce(1, *)
		let productText = NSAttributedString(string: " = \(product)")

		return value1 + productMark + value2 + productText
	}

	var result: InputResult {
		// Check if inputs are touched or empty
		if isFresh || isEmpty {
			return (
				statusText: NSAttributedString(string: "No Inputs Provided."),
				resultText: NSAttributedString(string: "")
			)
		}

		let statusText = "Calculating result from Input \(lastEditedIndex! + 1)"
		return (
			statusText: NSAttributedString(string: statusText),
			resultText: resultString
		)
	}
}

extension InputData {

	static private var inputsPerInput = 2
	static private var inputViews = 2

	static func makeEmptyInputData() -> InputData {
		let emptyInputs: [[Double?]] = Array.init(
			repeating: Array(repeating: nil, count: InputData.inputsPerInput),
			count: InputData.inputViews
		)
		return InputData(inputs: emptyInputs, lastEditedIndex: nil)
	}
}
