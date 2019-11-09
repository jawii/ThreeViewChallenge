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
			infoLabel.adjustsFontForContentSizeCategory = true
			infoLabel.font = DynamicFonts.scaledTitleFont
		}
	}
	@IBOutlet var resultLabel: UILabel! {
		didSet {
			resultLabel.adjustsFontForContentSizeCategory = true 
			resultLabel.font = DynamicFonts.scaledBoldFont
			resultLabel.accessibilityIdentifier = "result label"
		}
	}

	var inputResult: InputResult! {
		didSet {
			infoLabel.attributedText = inputResult.statusText
			resultLabel.attributedText = inputResult.resultText
		}
	}

	// MARK: - VC Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
		view.accessibilityIdentifier = "result view"
    }
}
