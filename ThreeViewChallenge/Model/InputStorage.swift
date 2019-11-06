//
//  InputStorage.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation

struct InputData: Codable {
	var inputs: [[Double?]]
	var lastEditedIndex: Int?
}

class InputStorage {

	private static let inputKey = "threeviewchallenge.inputs"

	// MARK: - Properties
	var inputData: InputData!

	// MARK: - Initialization
	init() {
		loadSavedData()
	}

	// MARK: - Private methods

	/// Loads saved data
	/// If no data saved. Set empty inputs
	private func loadSavedData() {
		let decoder = JSONDecoder()
		if let savedData = UserDefaults.standard.data(forKey: InputStorage.inputKey),
			let savedValue = try? decoder.decode(InputData.self, from: savedData) {
			self.inputData = savedValue
		} else {
			self.inputData = InputData(inputs: Array.init(repeating: [nil, nil], count: 2), lastEditedIndex: nil)
		}
	}

	/// Save current inputData to userdefaults
	private func saveValues() {
		let encoder = JSONEncoder()
		let data = try! encoder.encode(self.inputData)
		UserDefaults.standard.set(data, forKey: InputStorage.inputKey)
	}

	// MARK: - Public Methods

	func getValues(forInputIndex index: Int) -> [Double?] {
		assert(inputData.inputs.count > index, "Array index overflow")
		return inputData.inputs[index]
	}

	func setValues(_ values: [Double?], forIndex index: Int) {
		inputData.inputs[index] = values
		inputData.lastEditedIndex = index
		saveValues()
	}
}
