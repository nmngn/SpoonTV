//
//  AutoScrollingLSNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/2/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AutoScrollingNavigatorType {
    func toMainTabbar()
}

struct AutoScrollingNavigator: AutoScrollingNavigatorType {
    unowned let navigation: UINavigationController
    
    func toMainTabbar() {
        let mainTabbarViewController = MainTabbarController.instantiate()
        let navigator = MainTabbarNavigator(navigator: navigation)
        let useCase = MainTabbarUseCase()
        let mainTabbarViewModel = MainTabbarViewModel(navigator: navigator, useCase: useCase)
        mainTabbarViewController.bindViewModel(to: mainTabbarViewModel)
        navigation.viewControllers.append(mainTabbarViewController)
    }
}
