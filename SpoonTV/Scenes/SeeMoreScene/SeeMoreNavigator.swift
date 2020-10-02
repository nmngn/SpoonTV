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
    func toDetailScene(_ id: Int)
}

struct SeeMoreNavigator: SeeMoreNavigatorType {
    unowned let navigationController: UINavigationController

    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func toDetailScene(_ id: Int) {
        let controller = DetailViewController.instantiate()
        let useCase = DetailMovieUseCase(movieId: id)
        let navigator = DetailMovieNavigator(navigator: navigationController)
        let viewModel = DetailMovieViewModel(navigator: navigator, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
