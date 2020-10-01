//
//  UILabel+.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/23/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

extension UILabel {
    func wrapContent() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.4
    }
}
