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

		infoLabel.adjustsFontForContentSizeCategory = true
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

		textField.adjustsFontForContentSizeCategory = true
		textField.font = DynamicFonts.scaledBaseFont

		textField.isAccessibilityElement = true

		addSubview(textField)
		return textField
	}()

	private var infoLabelLeadingAnchor: NSLayoutConstraint!
	private var infoLabelCenterXAnchor: NSLayoutConstraint!

	// MARK: - Initialization

	required init(orderNumber: String, toolBarView: UIView) {
		super.init(frame: .zero)

		NSLayoutConstraint.activate([
			textField.topAnchor.constraint(equalTo: self.topAnchor),
			textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

			infoLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
			infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])

		infoLabelLeadingAnchor = infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		infoLabelLeadingAnchor.isActive = true
		infoLabelCenterXAnchor = infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		infoLabelCenterXAnchor.isActive = false

		// Let the textfield take the space
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		infoLabel.text = "VALUE \(orderNumber)"
		textField.accessibilityIdentifier = "textfield \(orderNumber)"
		textField.inputAccessoryView = toolBarView

		textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingDidBegin)
		textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingDidEnd)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private methods

	@objc private func textFieldEditingChanged() {
		infoLabelLeadingAnchor.isActive = !infoLabelLeadingAnchor.isActive
		infoLabelCenterXAnchor.isActive = !infoLabelCenterXAnchor.isActive

		UIView.animate(
			withDuration: 0.8,
			delay: 0,
			usingSpringWithDamping: 0.9,
			initialSpringVelocity: 10.0,
			options: [.curveEaseIn],
			animations: { [weak self] in
				guard let self = self else { return }
				self.infoLabel.textColor = self.infoLabelLeadingAnchor.isActive ? UIColor.systemGray2 : UIColor.black
				self.layoutIfNeeded()
			}, completion: nil)
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
