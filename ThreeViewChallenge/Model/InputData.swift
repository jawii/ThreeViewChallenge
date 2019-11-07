//
//  InputData.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 7.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation

struct InputData: Codable {

	// MARK: - Properties
	var inputs: [[Double?]]
	var lastEditedIndex: Int?


	// MARK: Computed Properties

	/// Is inputfields touched
	var isFresh: Bool { return lastEditedIndex == nil }

	/// Check if last entered values has any values
	var isEmpty: Bool {
		if isFresh { return false }
		return (inputs[lastEditedIndex!].compactMap { $0 }).isEmpty
	}

	var hasCompleteData: Bool {
		guard !isFresh && !isEmpty else { return false }

		let values = inputs[lastEditedIndex!]
		return values.count == (values.compactMap {$0}).count
 	}

	var resultString: String? {
		guard !isFresh && !isEmpty && hasCompleteData else { return nil }

		let values = inputs[lastEditedIndex!]
		let product = values.compactMap { $0 }.reduce(1, *)
		let text = "\(values[0]!) × \(values[1]!) = \(product)"
		return text
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
