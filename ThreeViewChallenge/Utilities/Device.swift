//
//  Device.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

struct Device {
	static var isLandscape: Bool {
		return UIApplication
			.shared
			.windows
			.first?
			.windowScene?
			.interfaceOrientation
			.isLandscape ?? false
	}
}
