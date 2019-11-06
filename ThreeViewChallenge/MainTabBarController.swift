//
//  MainTabBarController.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//


import UIKit

protocol InputCoordinator {
	func didSetInput(values: [Double?], atIndex index: Int)
}

class MainTabBarController: UITabBarController, InputCoordinator {
	// MARK: - Properties

	private var storage = InputStorage()

	lazy var firstVC: InputVC = {
		let firstVC = InputVC.instantiate()
		firstVC.view.backgroundColor = UIColor.systemBlue

		let tabBarIcon = UIImage(systemName: "1.circle.fill")
		let tabBarIconSelected = UIImage(systemName: "1.circle")
		firstVC.tabBarItem = UITabBarItem(title: "Input", image: tabBarIcon, selectedImage: tabBarIconSelected)

		firstVC.coordinator = self
		return firstVC
	}()

	lazy var secondVC: InputVC = {
		let secondVC = InputVC.instantiate()
		secondVC.view.backgroundColor = UIColor.systemRed

		let tabBarIcon = UIImage(systemName: "2.circle.fill")
		let tabBarIconSelected = UIImage(systemName: "2.circle")
		secondVC.tabBarItem = UITabBarItem(title: "Input", image: tabBarIcon, selectedImage: tabBarIconSelected)

		secondVC.coordinator = self
		return secondVC
	}()

	lazy var outPutVC: OutputVC = {
		let thirdVC = OutputVC.instantiate()
		let tabBarIcon = UIImage(systemName: "tray")
		let tabBarIconSelected = UIImage(systemName: "tray.fill")
		thirdVC.tabBarItem = UITabBarItem(title: "Output", image: tabBarIcon, selectedImage: tabBarIconSelected)

		return thirdVC
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		viewControllers = [firstVC, secondVC, outPutVC]

		firstVC.inputIndex = 0
		firstVC.values = storage.getValues(forInputIndex: 0)

		secondVC.inputIndex = 1
		secondVC.values = storage.getValues(forInputIndex: 1)

		outPutVC.values = storage.inputs.inputs
	}

	func didSetInput(values: [Double?], atIndex: Int) {
		storage.setValues(values, forIndex: atIndex)
		outPutVC.values = storage.inputs.inputs
	}
}
