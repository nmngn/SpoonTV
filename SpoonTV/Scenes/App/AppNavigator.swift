//
//  AppNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import UIKit

protocol AppNavigatorType {
    func toAutoScrolling()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toAutoScrolling() {
        let viewcontroller = AutoScrollingLSViewController.instantiate()
        let navigationController = UINavigationController()
        let navigator = AutoScrollingNavigator(window: window)
        let useCase = AutoScrollingUseCase()
        let viewModel = AutoScrollingViewModel(navigator: navigator, useCase: useCase)
        viewcontroller.bindViewModel(to: viewModel)
        navigationController.viewControllers.append(viewcontroller)
        window.rootViewController = navigationController
    }
}
