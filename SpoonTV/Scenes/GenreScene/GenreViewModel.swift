//
//  GenreViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MGArchitecture

struct GenreViewModel {
    let navigator: GenreNavigatorType
    let useCase: GenreUseCaseType
}

extension GenreViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let activityIndicator: Driver<Bool>
        let getGenre: Driver<[GenreTabbar]>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let output = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getGenre()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
            }
        return Output(error: errorTracker.asDriver(),
                      activityIndicator: activityIndicator.asDriver(),
                      getGenre: output)
    }
}
