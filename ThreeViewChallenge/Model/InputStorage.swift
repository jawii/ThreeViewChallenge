//
//  InputStorage.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation


class InputStorage {

	private static let input_userdefaults_key = "threeviewchallenge.inputs"

	// MARK: - Properties

	var inputData: InputData!


	// MARK: - Initalization

	init() {
		loadSavedData()
	}


	// MARK: - Private methods

	/// Loads saved data
	/// If no data saved, set empty inputs
	private func loadSavedData() {

		let decoder = JSONDecoder()
		if let savedData = UserDefaults.standard.data(forKey: InputStorage.input_userdefaults_key),
			let savedValue = try? decoder.decode(InputData.self, from: savedData) {
			self.inputData = savedValue
		} else {
			self.inputData = InputData.makeEmptyInputData()
		}
	}

	/// Save current inputData to userdefaults
	private func saveValues() {
		print("Saving values: \(inputData.inputs)")
		let encoder = JSONEncoder()
		do {
			let data = try encoder.encode(self.inputData)
			UserDefaults.standard.set(data, forKey: InputStorage.input_userdefaults_key)
		} catch let error {
			assertionFailure("Failed to save the data. \(error.localizedDescription)")
		}
	}

	// MARK: - Public Methods

	func values(forInputIndex index: Int) -> [Double?] {
		assert(inputData.inputs.count > index, "Array index overflow")
		return inputData.inputs[index]
	}

	func setValues(_ values: [Double?], forIndex index: Int) {
		inputData.inputs[index] = values
		inputData.lastEditedIndex = index
		saveValues()
	}
}
