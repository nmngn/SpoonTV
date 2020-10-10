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
    func toDetailArtistScene(_ id: Int)
}

struct DetailMovieNavigator: DetailMovieNavigatorType {
    unowned let navigationController: UINavigationController
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func reloadMovieDetail(_ id: Int) {
        let controller = DetailViewController.instantiate()
        let navigation = DetailMovieNavigator(navigationController: navigationController)
        let useCase = DetailMovieUseCase(movieId: id)
        let viewModel = DetailMovieViewModel(navigator: navigation, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func toDetailArtistScene(_ id: Int) {
        let controller = ArtistDetailViewController.instantiate()
        let useCase = ArtistDetailUseCase(artistId: id)
        let navigator = ArtistDetailNavigator(navigationController: navigationController)
        let viewModel = ArtistDetailViewModel(navigator: navigator, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }

}
