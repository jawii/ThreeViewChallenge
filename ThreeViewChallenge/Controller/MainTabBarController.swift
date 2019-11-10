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
		let resultNav = UINavigationController()
		resultNav.viewControllers = [resultVC]

		var inputViewControllers = [UIViewController]()

		for inputIndex in 0 ... storage.getInputAmount() - 1 {
			// Insert inputvc inside navigation viewcontroller for system provided title
			let navigationVC = UINavigationController()
			let inputVC = InputVC.makeInputVCForTabBar(inputIndex: inputIndex)

			inputVC.coordinator = self
			navigationVC.viewControllers = [inputVC]

			inputVC.values = storage.values(forInputIndex: inputIndex)
			inputVC.isActiveInput = storage.getLastEditedInputIndex() == inputIndex

			inputViewControllers.append(navigationVC)
		}

		viewControllers = inputViewControllers + [resultNav]
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
