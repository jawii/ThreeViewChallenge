//
//  ThirdVC.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

class ResultVC: UIViewController, Storyboarded {

	// MARK: - IBOutlets

	@IBOutlet var infoLabel: UILabel! {
		didSet {
			infoLabel.font = DynamicFonts.scaledTitleFont
		}
	}
	@IBOutlet var resultLabel: UILabel! {
		didSet {
			infoLabel.font = DynamicFonts.scaledBoldFont
		}
	}

	// MARK: - Properties

	var inputData: InputData!


	// MARK: - VC Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setViewForInputData()
	}


	// MARK: - Private functions

	private func setViewForInputData() {
		print(inputData.inputs)
		resultLabel.isHidden = false
		resultLabel.text = ""
		infoLabel.text = ""

		// Check if inputs are touched or empty
		if inputData.isFresh || inputData.isEmpty {
			infoLabel.text = "No Inputs Provided."
			resultLabel.isHidden = true
			return
		}

		let values = inputData.inputs[inputData.lastEditedIndex!]
		infoLabel.text = "Inputs from \(inputData.lastEditedIndex! + 1)"

		// Check if other one is missing
		if values.count != (values.compactMap {$0}).count {
			resultLabel.text = "Incomplete values."
			return
		}

		// Now there is input and result can be calculated
		let product = values.compactMap { $0 }.reduce(1, *)
		resultLabel.text = "\(values[0]!) × \(values[1]!) =  \(product)"
	}
}
