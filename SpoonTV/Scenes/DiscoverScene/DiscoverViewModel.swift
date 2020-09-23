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
        let morePopularTrigger: Driver<Void>
        let moreTopRatedTrigger: Driver<Void>
        let moreUpComingTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let morePopular: Driver<Void>
        let moreTopRated: Driver<Void>
        let moreUpcoming: Driver<Void>
        let popularMovie: Driver<[Movie]>
        let topRatedMovie: Driver<[Movie]>
        let upComingMovie: Driver<[Movie]>
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
        .map { $0.items }
        
        let topRated = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getTopRatedMovie()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        .map { $0.items }
        
        let upComing = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getUpComingMovie()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        .map { $0.items }
        
        let morePopular = input.morePopularTrigger
            .do(onNext: { _ in
                self.navigator.toSeeMoreScene(moreMovie: .popular)
            })
        let moreTopRated = input.moreTopRatedTrigger
            .do(onNext: { _ in
                self.navigator.toSeeMoreScene(moreMovie: .topRated)
            })
        let moreUpComing = input.moreUpComingTrigger
            .do(onNext: { _ in
                self.navigator.toSeeMoreScene(moreMovie: .upComing)
            })
        
        return Output(error: errorTracker.asDriver(),
                      isLoading: activityIndicator.asDriver(),
                      morePopular: morePopular,
                      moreTopRated: moreTopRated,
                      moreUpcoming: moreUpComing,
                      popularMovie: popular,
                      topRatedMovie: topRated,
                      upComingMovie: upComing)
    }
}
