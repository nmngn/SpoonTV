//
//  ListGenreViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct ListGenreViewModel {
    let navigator: ListGenreNavigatorType
    let useCase: ListGenreUseCaseType
}

extension ListGenreViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectBackTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let getListGenre: Driver<[Movie]>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let isLoadingMore: Driver<Bool>
        let selectedMovie: Driver<Void>
        let selectedBack: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activity = ActivityIndicator()
        
        let getItem = { (page: Int) -> Observable<PagingInfo<Movie>> in
            self.useCase.getMoreListGenre(page: page)
                .trackError(errorTracker)
                .trackActivity(activity)
        }
        
        let loadOutput = getPage(loadTrigger: input.loadTrigger,
                                 reloadTrigger: input.reloadTrigger,
                                 loadMoreTrigger: input.loadMoreTrigger,
                                 getItems: getItem)
        
        let (page, error, isLoading, isReloading, isLoadingMore) = loadOutput.destructured
        
        let listGenre = page.map { $0.items }
        
        let selectedBack = input.selectBackTrigger
            .do(onNext: self.navigator.back )
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(listGenre) { index, item in
                item[index.row]
            }
        .do(onNext: { self.navigator.toDetailScene($0.movieId) })
        .mapToVoid()
        
        return Output(getListGenre: listGenre,
                      error: Driver.merge(error, errorTracker.asDriver()),
                      isLoading: Driver.merge(activity.asDriver(), isLoading),
                      isReloading: isReloading,
                      isLoadingMore: isLoadingMore,
                      selectedMovie: selectedMovie,
                      selectedBack: selectedBack)
    }
}
