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
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let dataSearch: Driver<[Movie]>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let isLoadingMore: Driver<Bool>
        let isEmptyData: Driver<Bool>
        let isEmptyInput: Driver<Bool>
        let selectedMovie: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activity = ActivityIndicator()
        
        let textTrigger = input.textSearch
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
        
        let reloadTrigger = input.reloadTrigger
            .withLatestFrom(textTrigger)
        
        let loadMoreTrigger = input.loadMoreTrigger
            .withLatestFrom(textTrigger)
            
        let search = getPage(loadTrigger: Driver.merge(textTrigger),
                             reloadTrigger: reloadTrigger,
                             loadMoreTrigger: loadMoreTrigger) { query, page in
                                self.useCase.getMoreSearchData(page: page, query: query)
                                    .trackError(errorTracker)
                                    .trackActivity(activity)
        }
        
        let (page, error, isLoading, isReloading, isLoadingMore) = search.destructured
        
        let itemSearch = page
            .map { $0.items }
        
        let isEmpty = itemSearch
            .map { $0.isEmpty }
            .distinctUntilChanged()
        
        let isEmptyInput = input.textSearch
            .map { $0.isEmpty }
            .distinctUntilChanged()
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(itemSearch) { index, item in
                item[index.row]
            }
        .do(onNext: {
            self.navigator.toDetailScene($0.movieId)
        })
            .mapToVoid()
        
        return Output(dataSearch: itemSearch,
                      error: error,
                      isLoading: isLoading,
                      isReloading: isReloading,
                      isLoadingMore: isLoadingMore,
                      isEmptyData: isEmpty,
                      isEmptyInput: isEmptyInput,
                      selectedMovie: selectedMovie)
    }
}
