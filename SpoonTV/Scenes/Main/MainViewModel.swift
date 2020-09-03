//
//  MainViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

extension MainViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(_ input: MainViewModel.Input) -> MainViewModel.Output {
        return Output()
    }
}
