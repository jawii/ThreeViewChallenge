//
//  InputData.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 7.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation

struct InputData: Codable {
	var inputs: [[Double?]]
	var lastEditedIndex: Int?

	/// Is inputfields touched
	var isFresh: Bool { return lastEditedIndex == nil }

	/// Check if last entered values has any values
	var isEmpty: Bool {
		if lastEditedIndex == nil { return false }
		return (inputs[lastEditedIndex!].compactMap { $0 }).isEmpty
	}
}
