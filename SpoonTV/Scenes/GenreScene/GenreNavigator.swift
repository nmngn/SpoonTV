//
//  GenreNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import MGArchitecture

protocol GenreNavigatorType {
    func toListGenre(_ id: Int)
}

struct GenreNavigator: GenreNavigatorType {
    unowned let navigator: UINavigationController
    
    func toListGenre(_ id: Int) {
        let controller = ListGenreViewController.instantiate()
        let navigation = ListGenreNavigator(navigationController: navigator)
        let useCase = ListGenreUseCase(movieId: id)
        let viewModel = ListGenreViewModel(navigator: navigation, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigator.pushViewController(controller, animated: true)
    }
}
