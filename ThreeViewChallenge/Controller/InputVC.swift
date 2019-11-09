//
//  InputVC.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

class InputVC: UIViewController, Storyboarded {

	// MARK: Outlets
	@IBOutlet private var tableView: UITableView!

	// MARK: Properties
	var inputIndex: Int!
	var values: [Double?] = [] {
		didSet { tableView.reloadData() }
	}
	weak var coordinator: InputCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.register(InputViewCell.self, forCellReuseIdentifier: InputViewCell.reuseIdentifier)
		tableView.delegate = self
		tableView.dataSource = self

		let clearButton = UIBarButtonItem(title: "Clear all", style: .done, target: self, action: #selector(didTapClearButton))
		navigationItem.leftBarButtonItem = clearButton
    }

	@objc private func didTapClearButton() {
		let alertVC = UIAlertController(title: "Clear all inputs", message: "", preferredStyle: .alert)

		alertVC.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
		alertVC.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { [weak self] (_) in
			guard let self = self else { return }
			self.values = Array(repeating: nil, count: self.values.count)
			print(self.values)
			self.coordinator? .didSet(values: self.values, forIndex: self.inputIndex)
		}))

		present(alertVC, animated: true, completion: nil)
	}
}

extension InputVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("Tableview reload")
		return values.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: InputViewCell.reuseIdentifier, for: indexPath) as? InputViewCell else {
			fatalError("Tableview cell configuration error.")
		}

		cell.delegate = self
		let value = values[indexPath.row]
		print(value)
		cell.setupForInput(withInputOrder: indexPath.row, value: value)
		return cell
	}
}

extension InputVC: InputViewCellDelegate {

	func didSuccesfullyEditValue() {
		// Get all cells & values from every textfield and provide them back to coordinator
		var indexPaths = [IndexPath]()
		for index in 0 ... values.count {
			indexPaths.append(IndexPath(item: index, section: 0))
		}

		let cells = indexPaths.compactMap { tableView.cellForRow(at: $0) as? InputViewCell }
		let values = cells.map { $0.getTextFieldValue() }

		coordinator?.didSet(values: values, forIndex: self.inputIndex)
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
