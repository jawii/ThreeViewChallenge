//
//  MainTabBarController.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

protocol InputCoordinator: class {
	func didSetInput(values: [Double?], atIndex index: Int)
}

class MainTabBarController: UITabBarController, InputCoordinator {

	// MARK: - Properties
	private var storage = InputStorage()
	var firstVC: InputVC!
	var secondVC: InputVC!

	lazy var resultVC: ResultVC = {
		let resultVC = ResultVC.instantiate()
		resultVC.title = "Result"
		let tabBarIcon = UIImage(systemName: "tray")
		let tabBarIconSelected = UIImage(systemName: "tray.fill")
		resultVC.tabBarItem = UITabBarItem(title: "Result", image: tabBarIcon, selectedImage: tabBarIconSelected)
		return resultVC
	}()

	// MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
		// Set viewcontrollers inside navigationcontroller for the system provided title
		let firstNav = UINavigationController()
		firstVC = InputVC.makeInputVCForTabBar(inputIndex: 0)
		firstVC.coordinator = self
		firstNav.viewControllers = [firstVC]
		
		let secondNav = UINavigationController()
		secondVC = InputVC.makeInputVCForTabBar(inputIndex: 1)
		secondVC.coordinator = self
		secondNav.viewControllers = [secondVC]

		let resultNav = UINavigationController()
		resultNav.viewControllers = [resultVC]

		viewControllers = [firstNav, secondNav, resultNav]

		firstVC.setValues(values: storage.values(forInputIndex: 0))
		secondVC.setValues(values: storage.values(forInputIndex: 1))
		resultVC.inputData = storage.inputData
	}

	// MARK: - InputCoordinator - protocol

	func didSetInput(values: [Double?], atIndex index: Int) {
		// Set new values to storage
		storage.setValues(values, forIndex: index)
		// Input data is value type so set the new values to outputvc
		resultVC.inputData = storage.inputData
	}
}
