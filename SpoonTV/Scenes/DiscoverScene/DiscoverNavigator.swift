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
    func toDetailScene(_ id: Int)
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
    
    func toDetailScene(_ id: Int) {
        let controller = DetailViewController.instantiate()
        let useCase = DetailMovieUseCase(movieId: id)
        let navigator = DetailMovieNavigator(navigator: navigation)
        let viewModel = DetailMovieViewModel(navigator: navigator, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigation.pushViewController(controller, animated: true)
    }
    
}
