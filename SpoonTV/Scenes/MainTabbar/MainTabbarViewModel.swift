//
//  MainTabbarViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct MainTabbarViewModel {
    let navigator: MainTabbarNavigatorType
    let useCase: MainTabbarUseCaseType
}

extension MainTabbarViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let tabbar: Driver<[UIViewController]>
    }
    
    func transform(_ input: Input) -> Output {
        let tabbar = input.loadTrigger
            .map {
                self.navigator.getTabbarItems()
            }
        return Output(tabbar: tabbar)
    }
}
