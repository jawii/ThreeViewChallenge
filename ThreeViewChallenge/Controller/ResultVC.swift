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
			resultLabel.font = DynamicFonts.scaledBoldFont
			resultLabel.accessibilityIdentifier = "result label"
		}
	}

	// MARK: - Properties

	var inputData: InputData!

	// MARK: - VC Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
		view.accessibilityIdentifier = "result view"
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setViewForInputData()
	}

	// MARK: - Private functions

	private func setViewForInputData() {
		resultLabel.isHidden = false
		resultLabel.text = ""
		infoLabel.text = ""

		// Check if inputs are touched or empty
		if inputData.isFresh || inputData.isEmpty {
			infoLabel.text = "No Inputs Provided."
			resultLabel.isHidden = true
			return
		}

		infoLabel.text = "Inputs from \(inputData.lastEditedIndex! + 1)"
		if !inputData.hasCompleteData {
			resultLabel.text = "Incomplete values."
			return
		}

		// Now there is input and result can be calculated
		resultLabel.text = inputData.resultString
	}
}
