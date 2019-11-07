//
//  InputView.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

class InputView: UIView {

	// MARK: - Properties

	lazy private var infoLabel: UILabel = {
		let infoLabel = UILabel(frame: .zero)

		infoLabel.translatesAutoresizingMaskIntoConstraints = false
		infoLabel.textAlignment = .left
		infoLabel.textColor = UIColor.systemGray2
		infoLabel.font = DynamicFonts.scaledBaseFont

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
		textField.font = DynamicFonts.scaledBoldFont

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

	// MARK: - Initialization

	required init(orderNumber: String, toolBarView: UIView) {
		super.init(frame: .zero)

		contentStack.addArrangedSubview(textField)
		contentStack.addArrangedSubview(infoLabel)

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

		infoLabel.text = "VALUE \(orderNumber)"
		textField.inputAccessoryView = toolBarView

		textField.isAccessibilityElement = true 
		textField.accessibilityIdentifier = "textfield \(orderNumber)"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	/// Returns boolean whether the textfield is editing
	func isEditing() -> Bool {
		return textField.isFirstResponder
	}

	/// Returns textfield
	/// Side-effects: Sets textfield text empty if something else than double set
	func getNewValue() -> Double? {
		guard let text = textField.text else { return nil }
		guard let number = Double(text) else {
			textField.text = ""
			return nil
		}
		return number
	}

	func setTextFieldValue(_ value: Double?) {
		if let value = value {
			// remove zero decimals
			if value == value.rounded() {
				textField.text = String(Int(value))
			} else {
				textField.text = String(value)
			}
		} else {
			textField.text = ""
		}
	}
}
