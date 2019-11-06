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
	private var value: Double?  {
		didSet {
			if let value = value {
				textField.text = String(value)
			}
		}
	}

	// MARK: ChildViews
	lazy private var infoLabel: UILabel = {
		let infoLabel = UILabel(frame: .zero)
		infoLabel.backgroundColor = UIColor.red
		infoLabel.translatesAutoresizingMaskIntoConstraints = false
		infoLabel.text = "Input"
		addSubview(infoLabel)
		return infoLabel
	}()

	lazy private var textField: UITextField = {
		let textField = UITextField(frame: .zero)
		textField.backgroundColor = UIColor.yellow
		textField.keyboardType = .decimalPad
		textField.translatesAutoresizingMaskIntoConstraints = false
		addSubview(textField)

		return textField
	}()

	var toolBarView: UIView! {
		didSet {
			textField.inputAccessoryView = toolBarView
		}
	}

	// MARK: - Initialization
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
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	
	/// Returns boolean whether the textfield is editing
	func isTextFieldEditing() -> Bool {
		return textField.isFirstResponder
	}
}
