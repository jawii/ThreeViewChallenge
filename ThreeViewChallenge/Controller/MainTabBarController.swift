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
		_ = resultVC.view // load outlets
		setupTabBar()
		resultVC.inputResult = storage.getInputResult()
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
		firstVC.isActiveInput = storage.getLastEditedInputIndex() == 0

		secondVC.values = storage.values(forInputIndex: 1)
		secondVC.isActiveInput = storage.getLastEditedInputIndex() == 1

		viewControllers = [firstNav, secondNav, resultNav]
	}

	// MARK: - InputCoordinator - protocol

	func didSet(values: [Double?], forIndex index: Int) {
		storage.setValues(values, forIndex: index)

		// Input data is value type so set the new values to outputvc
		resultVC.inputResult = storage.getInputResult()

		// get all InputVCs excluding current index and set them inactive
		let resultVCs =
			self.viewControllers!
			.compactMap { $0 as? UINavigationController}
			.compactMap { $0.viewControllers[0] as? InputVC }

		for (vcIndex, viewController) in resultVCs.enumerated() {
			if vcIndex == index { continue }
			viewController.isActiveInput = false
		}
	}
}
