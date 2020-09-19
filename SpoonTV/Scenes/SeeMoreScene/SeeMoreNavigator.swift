//
//  SeeMoreNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/19/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

protocol SeeMoreNavigatorType {
    func back()
}

struct SeeMoreNavigator: SeeMoreNavigatorType {
    unowned let navigator: UINavigationController

    func back() {
        navigator.popViewController(animated: true)
    }
}
