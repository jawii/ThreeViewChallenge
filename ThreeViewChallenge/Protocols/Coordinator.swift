//
//  Coordinator.swift
//  Food Photo Diary
//
//  Created by Jaakko Kenttä on 24/06/2019.
//  Copyright © 2019 Jaakko Kenttä. All rights reserved.
//

import UIKit

protocol Coordinator {
	var childCoordinators: [Coordinator] { get set }
	var navigationController: UINavigationController { get set }

	func start()
}




