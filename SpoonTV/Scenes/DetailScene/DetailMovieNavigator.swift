//
//  DetailMovieNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/22/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

protocol DetailMovieNavigatorType {
    func back()
}

struct DetailMovieNavigator: DetailMovieNavigatorType {
    unowned let navigation: UINavigationController
    
    func back() {
        navigation.popViewController(animated: true)
    }
}
