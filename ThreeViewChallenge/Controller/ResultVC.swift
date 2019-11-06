//
//  ThirdVC.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

class ResultVC: UIViewController, Storyboarded {

	@IBOutlet private var valuesLabels: [UILabel]!

	var inputData: InputData!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		debugPrint("Last edited: \(inputData.lastEditedIndex)")
		
		let flattenedValues = inputData.inputs.reduce([], +)

		for (index, label) in valuesLabels.enumerated() {
			if let value = flattenedValues[index] {
				label.text = String(value)
			} else {
				label.text = "Not set"
			}
		}
	}
}
