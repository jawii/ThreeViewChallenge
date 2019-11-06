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

	// MARK: - Views
	lazy private var firstInputView: InputView = {
		let inputView = InputView()

		inputView.translatesAutoresizingMaskIntoConstraints = false
		inputView.toolBarView = toolBarView
		self.view.addSubview(inputView)

		return inputView
	}()

	lazy private var secondInputView: InputView = {
		let inputView = InputView()

		inputView.translatesAutoresizingMaskIntoConstraints = false
		inputView.toolBarView = toolBarView
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
			stack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
			stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
			stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
//			stack.heightAnchor.constraint(equalToConstant: 50)
		])
	}

    override func viewDidLoad() {
        super.viewDidLoad()


    }



	@IBAction private func toolBarDoneTapHandler() {
		print("ToolbarTap")
		// Get which textfield is tapped
		let currentInputView = secondInputView.isTextFieldEditing() ? secondInputView : firstInputView

		print(currentInputView)

		currentInputView.endEditing(true)


	}
}
