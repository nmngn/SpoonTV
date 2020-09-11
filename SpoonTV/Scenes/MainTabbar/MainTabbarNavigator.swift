//
//  MainTabbarNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/9/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

protocol MainTabbarNavigatorType {
    func getTabbarItems() -> [UIViewController]
}

struct MainTabbarNavigator: MainTabbarNavigatorType {
    unowned let navigator: UINavigationController
    
    func getTabbarItems() -> [UIViewController] {
        let mainTabBarController = MainTabbarController.instantiate()
// MARK: - Discover Tabbar
        let discoverController = DiscoverViewController.instantiate().then {
            $0.tabBarItem = UITabBarItem(title: "Discover",
                                         image: UIImage(systemName: "star"),
                                         selectedImage: nil)
        }
        let discoverNavigator = DiscoverNavigator(navigator: navigator)
        let discoverUseCase = DiscoverUseCase()
        let discoverViewModel = DiscoverViewModel(navigator: discoverNavigator,
                                                  useCase: discoverUseCase)
        discoverController.bindViewModel(to: discoverViewModel)
        
// MARK: - Genre Tabbar
        let genreController = GenreViewController.instantiate().then {
            $0.tabBarItem = UITabBarItem(title: "Genre",
                                         image: UIImage(systemName: "tv"),
                                         selectedImage: nil)
        }
        let genreNavigator = GenreNavigator(navigator: navigator)
        let genreUseCase = GenreUseCase()
        let genreViewModel = GenreViewModel(navigator: genreNavigator, useCase: genreUseCase)
        genreController.bindViewModel(to: genreViewModel)
        mainTabBarController.do {
            $0.viewControllers = [discoverController, genreController]
        }
        return [discoverController, genreController]
    }
}
