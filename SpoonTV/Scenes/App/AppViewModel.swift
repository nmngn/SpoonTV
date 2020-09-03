//
//  AppViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let nextScreen: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let toNextScreen = input.loadTrigger
            .do(onNext: { _ in
                self.navigator.toAutoScrolling()
            })
        
        return Output(
            nextScreen: toNextScreen
        )
    }
}
