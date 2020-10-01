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
    func reloadMovieDetail(_ id: Int)
}

struct DetailMovieNavigator: DetailMovieNavigatorType {
    unowned let navigator: UINavigationController
    
    func back() {
        navigator.popViewController(animated: true)
    }
    
    func reloadMovieDetail(_ id: Int) {
        let controller = DetailViewController.instantiate()
        let navigation = DetailMovieNavigator(navigator: navigator)
        let useCase = DetailMovieUseCase(movieId: id)
        let viewModel = DetailMovieViewModel(navigator: navigation, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigator.pushViewController(controller, animated: true)
        
    }
}
