//
//  DiscoverViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/9/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct DiscoverViewModel {
    let navigator: DiscoverNavigatorType
    let useCase: DiscoverUseCaseType
}

extension DiscoverViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let popularMovie: Driver<[PopularMovie]>
        let topRatedMovie: Driver<[TopRatedMovie]>
        let upComingMovie: Driver<[UpComingMovie]>
    }
    
    func transfrom(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let popular = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getPopularMovie()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let topRated = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getTopRatedMovie()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let upComing = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getUpComingMovie()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(
            error: errorTracker.asDriver(),
            isLoading: activityIndicator.asDriver(),
            popularMovie: popular,
            topRatedMovie: topRated,
            upComingMovie: upComing)
    }
}
