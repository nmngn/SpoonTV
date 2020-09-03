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
    func toMain()
}

struct AutoScrollingNavigator: AutoScrollingNavigatorType {
    unowned let window: UIWindow
    
    func toMain() {
        let viewController = MainViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
