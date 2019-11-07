//
//  InputVC.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

class InputVC: UIViewController, Storyboarded {

	// MARK: - Outlets
	@IBOutlet private var toolBarView: UIView!

	// MARK: - Properties
	var inputIndex: Int!
	weak var coordinator: InputCoordinator?

	lazy private var firstInputView: InputView = {
		let inputView = InputView(withText: "1", toolBarView: toolBarView)
		inputView.translatesAutoresizingMaskIntoConstraints = false
		return inputView
	}()

	lazy private var secondInputView: InputView = {
		let inputView = InputView(withText: "2", toolBarView: toolBarView)
		inputView.translatesAutoresizingMaskIntoConstraints = false
		return inputView
	}()

	// MARK: - Initialization
	override func loadView() {
		super.loadView()

		let stack = UIStackView(frame: .zero)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 20

		self.view.addSubview(stack)
		stack.addArrangedSubview(firstInputView)
		stack.addArrangedSubview(secondInputView)

		let margins = self.view.layoutMarginsGuide // safe area
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: margins.topAnchor, constant: 22),
			stack.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
			stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
			stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
		])
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		// Dismiss keyboard when view is tapped
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		self.view.addGestureRecognizer(tapGesture)
    }

	// MARK: - Private methods

	@objc private func dismissKeyboard() {
		coordinator?.didSetInput(values: [firstInputView.getNewValue(), secondInputView.getNewValue()], atIndex: inputIndex)
		view.endEditing(true)
	}

	// MARK: - IBActions

	@IBAction private func toolBarDoneTapHandler() {
		dismissKeyboard()
	}

	// MARK: - Public Methods
	
	func setValues(values: [Double?]) {
		firstInputView.setTextFieldValue(values[0])
		secondInputView.setTextFieldValue(values[1])
	}
}


extension InputVC {
	static func makeInputVCForTabBar(inputIndex: Int) -> InputVC {
		let inputVC = InputVC.instantiate()
		inputVC.inputIndex = inputIndex
		inputVC.title = "INPUT \(inputIndex + 1)"

		let tabBarIcon = UIImage(systemName: "\(inputIndex + 1).circle.fill")
		let tabBarIconSelected = UIImage(systemName: "\(inputIndex + 1).circle")
		inputVC.tabBarItem = UITabBarItem(title: "Input \(inputIndex + 1)", image: tabBarIcon, selectedImage: tabBarIconSelected)

		inputVC.view.accessibilityIdentifier = "input \(inputIndex + 1)"

		return inputVC
	}
}
