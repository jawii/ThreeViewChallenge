//
//  DynamicFonts.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 7.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

struct DynamicFonts {

	// Returns standard font, scaled up for Dynamic Type.
	static var scaledBaseFont: UIFont {
		let regular = UIFont(name: "AvenirNext-Regular", size: 14)!
		let metrics = UIFontMetrics(forTextStyle: .body)
		return metrics.scaledFont(for: regular)
	}

	// Returns standard bold font, scaled up for Dynamic Type.
	static var scaledBoldFont: UIFont {
		let demibold = UIFont(name: "AvenirNext-DemiBold", size: 14)!
		let metrics = UIFontMetrics(forTextStyle: .body)
		return metrics.scaledFont(for: demibold)
	}

	// Returns .headline font, scaled up to Dynamic Type.
	static var scaledTitleFont: UIFont {
		let titleFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
		let metrics = UIFontMetrics(forTextStyle: .headline)
		return metrics.scaledFont(for: titleFont)
	}

	// Returns .largetTitle font, scaled up to Dynamic Type.
//	static var scaledlargeTitleFont: UIFont {
//		let titleFont = UIFont(name: "AvenirNext-DemiBold", size: 20)!
//		let metrics = UIFontMetrics(forTextStyle: .largeTitle)
//		return metrics.scaledFont(for: titleFont)
//	}

}
