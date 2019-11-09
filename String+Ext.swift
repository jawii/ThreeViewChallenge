//
//  String+Ext.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 9.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation

extension String {
	var convertedToDouble: Double? {
		let numberFormatter = NumberFormatter()
		numberFormatter.locale = Locale.current

		if let nsNumber = numberFormatter.number(from: self) {
			return Double(truncating: nsNumber)
		}
		return nil
	}
}
