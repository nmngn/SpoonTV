//
//  AutoScrollingLSViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/2/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct AutoScrollingViewModel {
    let navigator: AutoScrollingNavigatorType
    let useCase: AutoScrollingUseCaseType
}

extension AutoScrollingViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let toMain: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let toMain = input.loadTrigger
            .do(onNext: { _ in
                self.navigator.toMain()
            })
        
        return Output(
            toMain: toMain
        )
    }
}
