//
//  DetailMovieViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/22/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct DetailMovieViewModel {
    let navigator: DetailMovieNavigatorType
    let useCase: DetailMovieUseCaseType
}

extension DetailMovieViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
        let backTrigger: Driver<Void>
    }
    struct Output {
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let getDetail: Driver<MovieDetail>
        let getSimilar: Driver<[Movie]>
        let selectedBack: Driver<Void>
        let getActor: Driver<[ActorOfMovie]>
        let selectedMovie: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activity = ActivityIndicator()
            
        let loadOutput = getItem(loadTrigger: input.loadTrigger,
                                 reloadTrigger: input.reloadTrigger) { _ -> Observable<MovieDetail> in
                                    self.useCase.getDetailMovie()
                                        .trackError(errorTracker)
                                        .trackActivity(activity)
        }
        
        let loadSimilar = getItem(loadTrigger: input.loadTrigger,
                                  reloadTrigger: input.reloadTrigger) { _ -> Observable<[Movie]> in
                                    self.useCase.getSimilarMovie()
                                        .trackError(errorTracker)
                                        .trackActivity(activity)
        }
        let loadActor = getItem(loadTrigger: input.loadTrigger,
                                reloadTrigger: input.reloadTrigger) { _ -> Observable<[ActorOfMovie]> in
                                    self.useCase.getActor()
                                    .trackError(errorTracker)
                                    .trackActivity(activity)
        }
        
        let data = loadOutput.item
            .map { $0 }
        let similar = loadSimilar.item
            .map { $0 }
        let actor = loadActor.item
            .map { $0 }
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(similar) { index, item in
                item[index.row]
            }
            .map { $0 }
            .do(onNext: {
                self.navigator.reloadMovieDetail($0.movieId)
            })
            .withLatestFrom(input.reloadTrigger)
            .mapToVoid()
        
        let selectedBack = input.backTrigger
            .do( onNext: self.navigator.back)
        
        return Output(error: errorTracker.asDriver(),
                      isLoading: activity.asDriver(),
                      getDetail: data,
                      getSimilar: similar,
                      selectedBack: selectedBack,
                      getActor: actor,
                      selectedMovie: selectedMovie)
    }
}
