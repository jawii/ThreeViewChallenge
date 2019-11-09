//
//  Doulbe+Ext.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 9.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation

extension Double {
	/// If only zero desimals, return int version. Otherwise rounds to 5 digits.
	var cleanString: String {
		if self == rounded() { return String(Int(self)) }

		let formatter = NumberFormatter()
		formatter.formattingContext = .standalone
		formatter.maximumFractionDigits = 5

		return formatter.string(from: NSNumber(value: self))!
	}
}
