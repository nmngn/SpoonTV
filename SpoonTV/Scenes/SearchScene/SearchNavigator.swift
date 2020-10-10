//
//  SearchNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/15/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchNavigatorType {
    func toDetailScene(_ id: Int)
}

struct SearchNavigator: SearchNavigatorType {
    unowned let navigator: UINavigationController
    
    func toDetailScene(_ id: Int) {
        let controller = DetailViewController.instantiate()
        let navigation = DetailMovieNavigator(navigationController: navigator)
        let useCase = DetailMovieUseCase(movieId: id)
        let viewModel = DetailMovieViewModel(navigator: navigation, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigator.pushViewController(controller, animated: true)
    }
}
