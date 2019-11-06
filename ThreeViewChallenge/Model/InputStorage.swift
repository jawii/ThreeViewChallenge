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
}

class InputStorage {

	private static let inputKey = "threeviewchallenge.inputs"

	// MARK: - Properties
	var inputs: InputData!

	// MARK: - Initialization
	init() {
		loadInputs()
	}


	// MARK: - Private methods
	private func loadInputs() {
		let decoder = JSONDecoder()
		if let savedData = UserDefaults.standard.data(forKey: InputStorage.inputKey),
			let savedValue = try? decoder.decode(InputData.self, from: savedData) {
			self.inputs = savedValue
		} else {
			self.inputs = InputData(inputs: Array.init(repeating: [nil, nil], count: 2))
		}
	}

	private func saveValues() {
		let encoder = JSONEncoder()
		let data = try! encoder.encode(self.inputs)
		UserDefaults.standard.set(data, forKey: InputStorage.inputKey)
	}

	// MARK: - Public Methods

	func getValues(forInputIndex index: Int) -> [Double?] {
//		guard inputs.count > index else { return [] }
		return inputs.inputs[index]
	}

	func setValues(_ values: [Double?], forIndex index: Int) {
		inputs.inputs[index] = values
		saveValues()
	}
}
