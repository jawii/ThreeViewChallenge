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
	var values: [Double?] = [] {
		didSet {
			if let firstValue = values[0]  {
				firstInputView.setTextFieldValue(String(firstValue))
			}
			if let secondValue = values[1] {
				secondInputView.setTextFieldValue(String(secondValue))
			}
		}
	}
	var coordinator: InputCoordinator?

	lazy private var firstInputView: InputView = {
		let inputView = InputView(withText: "1", toolBarView: toolBarView)
		inputView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(inputView)
		return inputView
	}()

	lazy private var secondInputView: InputView = {
		let inputView = InputView(withText: "2", toolBarView: toolBarView)
		inputView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(inputView)
		return inputView
	}()

	// MARK: - Initialization
	override func loadView() {
		super.loadView()

		let stack = UIStackView(frame: .zero)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 20

		self.view.addSubview(stack)
		stack.addArrangedSubview(firstInputView)
		stack.addArrangedSubview(secondInputView)

		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 20),
			stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
			stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
			stack.heightAnchor.constraint(equalToConstant: 100)
		])
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction private func toolBarDoneTapHandler() {
		print("ToolbarTap")
		// Get which inputviews is being edited
		let currentInputView = secondInputView.isEditing() ? secondInputView : firstInputView

		coordinator?.didSetInput(values: [firstInputView.getNewValue(), secondInputView.getNewValue()], atIndex: inputIndex)
		currentInputView.endEditing(true)
	}
}


extension InputVC {
	static func makeInputVCForTabBar(inputIndex: Int) -> InputVC {
		let inputVC = InputVC.instantiate()
		inputVC.inputIndex = inputIndex
		inputVC.title = "INPUT \(inputIndex + 1)"

		let tabBarIcon = UIImage(systemName: "\(inputIndex + 1).circle.fill")
		let tabBarIconSelected = UIImage(systemName: "\(inputIndex + 1).circle")
		inputVC.tabBarItem = UITabBarItem(title: "Input", image: tabBarIcon, selectedImage: tabBarIconSelected)

		return inputVC
	}
}
