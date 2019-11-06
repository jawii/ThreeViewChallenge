//
//  MainTabBarController.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//


import UIKit

class MainTabBarController: UITabBarController {

	// MARK: - Properties
	let firstVC = FirstVC.instantiate()
	let secondVC = SecondVC.instantiate()
	let thirdVC = ThirdVC.instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()

		viewControllers = [firstVC, secondVC, thirdVC]

		firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
		secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
		thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 2)
	}
}
