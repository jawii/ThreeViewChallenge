//
//  MainTabBarController.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

protocol InputCoordinator: class {
	func didSet(values: [Double?], forIndex index: Int)
}

class MainTabBarController: UITabBarController, InputCoordinator {

	// MARK: - Properties
	private var storage = InputStorage()

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
		_ = resultVC.view
		setupTabBar()
		resultVC.inputResult = storage.inputData.result
	}

	private func setupTabBar() {
		// Set viewcontrollers inside navigationcontroller for the system provided title
		let firstNav = UINavigationController()
		let firstVC = InputVC.makeInputVCForTabBar(inputIndex: 0)
		firstVC.coordinator = self
		firstNav.viewControllers = [firstVC]

		let secondNav = UINavigationController()
		let secondVC = InputVC.makeInputVCForTabBar(inputIndex: 1)
		secondVC.coordinator = self
		secondNav.viewControllers = [secondVC]

		let resultNav = UINavigationController()
		resultNav.viewControllers = [resultVC]

		firstVC.values = storage.values(forInputIndex: 0)
		secondVC.values = storage.values(forInputIndex: 1)

		viewControllers = [firstNav, secondNav, resultNav]
	}

	// MARK: - InputCoordinator - protocol

	func didSet(values: [Double?], forIndex index: Int) {
		// Set new values to storage
		storage.setValues(values, forIndex: index)
		// Input data is value type so set the new values to outputvc
		resultVC.inputResult = storage.inputData.result
	}
}
