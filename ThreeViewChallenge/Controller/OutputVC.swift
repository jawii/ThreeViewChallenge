//
//  ThirdVC.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 6.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import UIKit

class OutputVC: UIViewController, Storyboarded {

	@IBOutlet private var valuesLabels: [UILabel]!

	var values: [[Double?]]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let flattenedValues = values.reduce([], +)

		for (index, label) in valuesLabels.enumerated() {
			if let value = flattenedValues[index] {
				label.text = String(value)
			} else {
				label.text = "Not set"
			}
		}
	}
}
