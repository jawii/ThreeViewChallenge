//
//  NSAttributedString+Ext.swift
//  ThreeViewChallenge
//
//  Created by Jaakko Kenttä on 9.11.2019.
//  Copyright © 2019 com.jaakkokentta. All rights reserved.
//

import Foundation

func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}
