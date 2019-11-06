//
//  StoryBoarded.swift
//  Food Photo Diary
//
//  Created by Jaakko Kenttä on 24/06/2019.
//  Copyright © 2019 Jaakko Kenttä. All rights reserved.
//

import UIKit

protocol Storyboarded {
	static func instantiate(storyboard: String) -> Self
}

extension Storyboarded where Self: UIViewController {
	static func instantiate(storyboard: String = "Main") -> Self {
		let fullName = NSStringFromClass(self)
		let className = fullName.components(separatedBy: ".")[1]
		let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
		return storyboard.instantiateViewController(withIdentifier: className) as! Self
	}
}
