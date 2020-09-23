//
//  SearchViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/15/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MGArchitecture

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
}

extension SearchViewModel: ViewModelType {
    
    struct Input {
        let textSearch: Driver<String>
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let searchMovie: Driver<[Movie]>
        let searchArtist: Driver<[Artist]>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let isLoadingMore: Driver<Bool>
        let isEmptyData: Driver<Bool>
        let isEmptyInput: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activity = ActivityIndicator()
        
        let textTrigger = input.textSearch
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .asDriver()
        
        let reloadTrigger = input.reloadTrigger
            .withLatestFrom(textTrigger)
        
        let loadMoreTrigger = input.loadMoreTrigger
            .withLatestFrom(textTrigger)
        
        let movieData = getPage(loadTrigger: textTrigger,
                                reloadTrigger: reloadTrigger,
                                loadMoreTrigger: loadMoreTrigger) { query, page in
                                    self.useCase.getMoreMovie(page: page, query: query)
                                        .trackError(errorTracker)
                                        .trackActivity(activity)
        }
        
        let artistData = getPage(loadTrigger: textTrigger,
                                 reloadTrigger: reloadTrigger,
                                 loadMoreTrigger: loadMoreTrigger) { query, page in
                                    self.useCase.getMoreArtist(page: page, query: query)
                                        .trackError(errorTracker)
                                        .trackActivity(activity)
        }
        
        let (pageMovie, errorMovie, isLoadingMovie, isReloadingMovie, isLoadingMoreMovie) = movieData.destructured
        let (pageArtist, errorArtist, isLoadingArtist, isReloadingArtist, isLoadingMoreArtist) = artistData.destructured
        let error = Driver.merge(errorMovie, errorArtist)
        let isLoading = Driver.merge(isLoadingMovie, isLoadingArtist)
        let isReloading = Driver.merge(isReloadingMovie, isReloadingArtist)
        let isLoadingMore = Driver.merge(isLoadingMoreMovie, isLoadingMoreArtist)
        
        let moviesResult = pageMovie
            .map { $0.items }
        
        let artistResult = pageArtist
            .map { $0.items }
        
        let isEmpty = moviesResult
            .map { $0.isEmpty }
            .distinctUntilChanged()
        
        let isEmptyInput = input.textSearch
            .map { $0.isEmpty }
            .distinctUntilChanged()
        
        return Output(searchMovie: moviesResult,
                      searchArtist: artistResult,
                      error: error.asDriver(),
                      isLoading: isLoading.asDriver(),
                      isReloading: isReloading.asDriver(),
                      isLoadingMore: isLoadingMore.asDriver(),
                      isEmptyData: isEmpty,
                      isEmptyInput: isEmptyInput
        )
    }
}
