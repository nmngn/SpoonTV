//
//  MainNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol MainNavigatorType {
    
}

struct MainNavigator: MainNavigatorType {
    unowned let navigation: UINavigationController

    func toMain() {
        let viewController = MainViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigation.pushViewController(navigationController, animated: true)
    }
}
