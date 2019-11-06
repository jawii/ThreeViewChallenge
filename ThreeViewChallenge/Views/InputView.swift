//
//  InputView.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

class InputView: UIView {

	// MARK: Properties
	var values: [Int]!

	lazy private var infoLabel: UILabel = {
		let infoLabel = UILabel(frame: .zero)

		infoLabel.translatesAutoresizingMaskIntoConstraints = false
		infoLabel.textAlignment = .center
		infoLabel.text = "Input"

		addSubview(infoLabel)
		return infoLabel
	}()

	lazy private var textField: UITextField = {
		let textField = UITextField(frame: .zero)
		textField.translatesAutoresizingMaskIntoConstraints = false

		textField.backgroundColor = UIColor.systemFill
		textField.layer.cornerRadius = 8 
		textField.keyboardType = .decimalPad
		textField.textAlignment = .center
		textField.placeholder = "Tap to set"

		addSubview(textField)
		return textField
	}()

	lazy private var contentStack: UIStackView = {
		let stack = UIStackView(frame: .zero)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		self.addSubview(stack)
		return stack
	}()

	private var toolBarView: UIView! {
		didSet {
			textField.inputAccessoryView = toolBarView
		}
	}

	// MARK: - Initialization
	required init(withText infoText: String, toolBarView: UIView) {
		super.init(frame: .zero)

		contentStack.addArrangedSubview(infoLabel)
		contentStack.addArrangedSubview(textField)

		NSLayoutConstraint.activate([
			contentStack.widthAnchor.constraint(equalTo: self.widthAnchor),
			contentStack.heightAnchor.constraint(equalTo: self.heightAnchor),
			contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
		])
		
		// Let the textfield take the space
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		infoLabel.text = infoText
		textField.inputAccessoryView = toolBarView
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		let isLandscape = Device.isLandscape
		contentStack.axis = isLandscape ? .horizontal : .vertical
		contentStack.spacing = isLandscape ? 50 : 20
	}

	// MARK: - Public methods

	/// Returns boolean whether the textfield is editing
	func isEditing() -> Bool {
		return textField.isFirstResponder
	}

	func getNewValue() -> Double? {
		guard let text = textField.text else { return nil }
		guard let number = Double(text) else { return nil }
		return number
	}

	func setTextFieldValue(_ value: String) {
		print("Setting value: \(value)")
		textField.text = value
	}
}
