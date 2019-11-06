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
		infoLabel.backgroundColor = UIColor.red
		infoLabel.translatesAutoresizingMaskIntoConstraints = false
		infoLabel.textAlignment = .center
		infoLabel.text = "Input"
		addSubview(infoLabel)
		return infoLabel
	}()

	lazy private var textField: UITextField = {
		let textField = UITextField(frame: .zero)
		textField.backgroundColor = UIColor.yellow
		textField.keyboardType = .decimalPad
		textField.textAlignment = .center
		textField.translatesAutoresizingMaskIntoConstraints = false
		addSubview(textField)

		return textField
	}()

	private var toolBarView: UIView! {
		didSet {
			textField.inputAccessoryView = toolBarView
		}
	}

	// MARK: - Initialization
	required init(withText infoText: String, toolBarView: UIView) {
		super.init(frame: .zero)

		let stack = UIStackView(frame: .zero)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical

		self.addSubview(stack)
		stack.addArrangedSubview(infoLabel)
		stack.addArrangedSubview(textField)

		NSLayoutConstraint.activate([
			stack.widthAnchor.constraint(equalTo: self.widthAnchor),
			stack.heightAnchor.constraint(equalTo: self.heightAnchor),
			stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			stack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
		// Let the textfield take the space
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		infoLabel.text = infoText

		textField.inputAccessoryView = toolBarView
	}
/*
	override init(frame: CGRect) {
		super.init(frame: frame)

		let stack = UIStackView(frame: .zero)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical

		self.addSubview(stack)
		stack.addArrangedSubview(infoLabel)
		stack.addArrangedSubview(textField)

		NSLayoutConstraint.activate([
			stack.widthAnchor.constraint(equalTo: self.widthAnchor),
			stack.heightAnchor.constraint(equalTo: self.heightAnchor),
			stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			stack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
		// Let the textfield take the space
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
	}
*/
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
		textField.text = value
	}
}
