//
//  ArtistDetailViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MGArchitecture

struct ArtistDetailViewModel {
    let navigator: ArtistDetailNavigatorType
    let useCase: ArtistDetailUseCaselType
}

extension ArtistDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
        let backTrigger: Driver<Void>
        
    }
    struct Output {
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let selectedback: Driver<Void>
        let getDetail: Driver<ArtistDetail>
        let getMovie: Driver<[Movie]>
        let toDetailScene: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activity = ActivityIndicator()
        
        let output = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getDetail()
                    .trackError(errorTracker)
                    .trackActivity(activity)
                    .asDriverOnErrorJustComplete()
            }
        
        let movie = getItem(loadTrigger: input.loadTrigger,
                            reloadTrigger: input.reloadTrigger) { _ -> Observable<[Movie]> in
            self.useCase.getMovieOfArtist()
                .trackError(errorTracker)
                .trackActivity(activity)
        }
        
        let result = movie.item
            .map { $0 }
        
        let selectedMovie = input.selectTrigger
            .withLatestFrom(result) { index, item in
                item[index.row]
            }
            .do { self.navigator.toDetailScene($0.movieId) }
            .mapToVoid()

        let selectedBack = input.backTrigger
            .do { _ in
                self.navigator.back()
            }

        return Output(error: errorTracker.asDriver(),
                      isLoading: activity.asDriver(),
                      selectedback: selectedBack,
                      getDetail: output,
                      getMovie: result,
                      toDetailScene: selectedMovie)
    }
}
