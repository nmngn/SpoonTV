//
//  MainTabbarController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/9/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture

final class MainTabbarController: UITabBarController, BindableType {
    
    var viewModel: MainTabbarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        let input = MainTabbarViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        output.tabbar
            .drive(tabbarBinder)
            .disposed(by: rx.disposeBag)
    }
}

extension MainTabbarController {
    var tabbarBinder: Binder<[UIViewController]> {
        return Binder(self) { vc, vcs in
            vc.setViewControllers(vcs, animated: false)
        }
    }
}

extension MainTabbarController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "MainTabbar", bundle: nil)
}
