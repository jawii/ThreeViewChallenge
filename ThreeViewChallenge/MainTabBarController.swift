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
	lazy var firstVC: InputVC = {
		let firstVC = InputVC.instantiate()
		firstVC.view.backgroundColor = UIColor.systemBlue

		let tabBarIcon = UIImage(systemName: "flame")
		let tabBarIconSelected = UIImage(systemName: "flame.fill")
		firstVC.tabBarItem = UITabBarItem(title: "1", image: tabBarIcon, selectedImage: tabBarIconSelected)

		return firstVC
	}()

	lazy var secondVC: InputVC = {
		let secondVC = InputVC.instantiate()
		secondVC.view.backgroundColor = UIColor.systemRed

		let tabBarIcon = UIImage(systemName: "heart")
		let tabBarIconSelected = UIImage(systemName: "heart.fill")
		secondVC.tabBarItem = UITabBarItem(title: "2", image: tabBarIcon, selectedImage: tabBarIconSelected)

		return secondVC
	}()

	lazy var thirdVC: ThirdVC = {
		let thirdVC = ThirdVC.instantiate()

		let tabBarIcon = UIImage(systemName: "tray")
		let tabBarIconSelected = UIImage(systemName: "tray.fill")
		thirdVC.tabBarItem = UITabBarItem(title: "3", image: tabBarIcon, selectedImage: tabBarIconSelected)

		return thirdVC
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		viewControllers = [firstVC, secondVC, thirdVC]

	}
}
