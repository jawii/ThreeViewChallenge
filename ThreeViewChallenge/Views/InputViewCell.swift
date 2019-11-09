//
//  InputView.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

protocol InputViewCellDelegate: class {
	func didSuccesfullyEditValue()
}

class InputViewCell: UITableViewCell {

	static let reuseIdentifier = "InputViewCellIdentifier"

	// MARK: - Properties

	lazy private var infoLabel: UILabel = {
		let infoLabel = UILabel(frame: .zero)

		infoLabel.translatesAutoresizingMaskIntoConstraints = false
		infoLabel.textAlignment = .left
		infoLabel.textColor = UIColor.systemGray2

		infoLabel.adjustsFontForContentSizeCategory = true
		infoLabel.font = DynamicFonts.scaledBoldFont

		addSubview(infoLabel)
		infoLabelLeadingAnchor = infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
		infoLabelCenterXAnchor = infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		NSLayoutConstraint.activate([
			infoLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
			infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
			infoLabelLeadingAnchor
		])

		// Let the textfield take the space
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		infoLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

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
		textField.textColor = textFieldTextColor

		textField.isAccessibilityElement = true
		textField.adjustsFontForContentSizeCategory = true
		textField.font = DynamicFonts.scaledBaseFont

		// For iPad
		textField.returnKeyType = .done
		textField.delegate = self

		// Add Constraints
		addSubview(textField)
		NSLayoutConstraint.activate([
			textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
			textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
			textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
			textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
		])

		// Setup ToolBar
		let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
		toolbar.barStyle = .default
		let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textFieldDoneBtnTapHandler))
		doneButton.isAccessibilityElement = true
		doneButton.accessibilityIdentifier = "Done"

		let clearButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(textFieldClearBtnTapHandler))

		let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(textFieldCancelBtnTapHandler))

		let plusMinusImage = UIImage(systemName: "plus.slash.minus")

		let flipMarkBtn = UIBarButtonItem(image: plusMinusImage, style: .done, target: self, action: #selector(flipValueMarkBtnTapHandler))
		toolbar.items = [
			cancelButton,
			clearButton,
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
			flipMarkBtn,
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
			doneButton
		]
		toolbar.sizeToFit()
		textField.inputAccessoryView = toolbar

		textField.addTarget(self, action: #selector(textFieldisEditingStatusChanged), for: .editingDidBegin)
		textField.addTarget(self, action: #selector(textFieldisEditingStatusChanged), for: .editingDidEnd)
		textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)

		return textField
	}()

	private var infoLabelLeadingAnchor: NSLayoutConstraint!
	private var infoLabelCenterXAnchor: NSLayoutConstraint!
	private var infoLabelHighLightColor = UIColor.systemTeal
	private var infoLabelColor = UIColor.systemGray2
	private var textFieldTextColor = UIColor.systemIndigo
	private var textFieldErrorTextColor = UIColor.systemRed
	private var oldValue: String?

	weak var delegate: InputViewCellDelegate?

	// MARK: - Initialization

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	func setupForInput(withInputOrder order: Int, value: Double?) {

		infoLabel.text = "VALUE \(order + 1)"
		textField.accessibilityIdentifier = "textfield \(order)"

		if let value = value {
			// remove zero decimals
			textField.text = value.cleanString
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		textField.text = "" 
	}

	// MARK: - Private methods

	@objc private func textFieldDoneBtnTapHandler() {
		if let text = textField.text {
			if text.isEmpty || text.convertedToDouble != nil {
				delegate?.didSuccesfullyEditValue()
			} else {
				textField.text = ""
			}
		}
		textField.resignFirstResponder()
	}

	@objc private func textFieldValueChanged() {
		if let text = textField.text {
			if text.isEmpty { return }

			if text.convertedToDouble == nil {
				textField.textColor = textFieldErrorTextColor
			} else {
				textField.textColor = textFieldTextColor
			}
		}
	}

	@objc private func textFieldisEditingStatusChanged() {
		if textField.isEditing { oldValue = textField.text }

		// Animate infolabel to center by flipping constraints and color
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
				self.infoLabel.textColor = self.infoLabelLeadingAnchor.isActive ? self.infoLabelColor : self.infoLabelHighLightColor
				self.layoutIfNeeded()
			}, completion: nil)
	}

	@objc private func textFieldClearBtnTapHandler() {
		textField.text = ""
	}

	@objc private func flipValueMarkBtnTapHandler() {
		if let text = textField.text, let number = text.convertedToDouble {
			textField.text = (-1 * number).cleanString
		}
	}

	@objc private func textFieldCancelBtnTapHandler() {
		textField.text = oldValue
		oldValue = ""
		textField.resignFirstResponder()
	}

	// MARK: - Public methods

	/// Returns textfield
	func getTextFieldValue() -> Double? {
		guard let text = textField.text else { return nil }
		if text.isEmpty { return nil }

		guard let number = text.convertedToDouble else {
			assertionFailure("Textfield contains non-number value")
			textField.text = ""
			return nil
		}
		return number
	}
}

extension InputViewCell: UITextFieldDelegate {
	// If user presses return key on iPad, consider it like pressing the done button on the toolbar
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textFieldDoneBtnTapHandler()
		return true
	}

}
