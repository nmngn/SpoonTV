//
//  DiscoverNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/9/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

protocol DiscoverNavigatorType {
    func toSeeMoreScene(moreMovie: MoreMovie)
    
}

struct DiscoverNavigator: DiscoverNavigatorType {
    unowned var navigation: UINavigationController

    func toSeeMoreScene(moreMovie: MoreMovie) {
        let controller = SeeMoreViewController.instantiate()
        let useCase = SeeMoreUseCase()
        let navigator = SeeMoreNavigator(navigator: navigation)
        let viewModel = SeeMoreViewModel(navigator: navigator, useCase: useCase, moreMovie: moreMovie)
        controller.bindViewModel(to: viewModel)
        navigation.pushViewController(controller, animated: true)
    }
}
