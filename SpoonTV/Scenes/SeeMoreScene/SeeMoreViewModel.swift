//
//  SeeMoreViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/19/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import MGArchitecture

struct SeeMoreViewModel {
    let navigator: SeeMoreNavigatorType
    let useCase: SeeMoreUseCaseType
    let moreMovie: MoreMovie
}

extension SeeMoreViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
        
    }
    struct Output {
        let getMore: Driver<[Movie]>
        let selectedBack: Driver<Void>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadMore: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let getItems = { (page: Int) -> Observable<PagingInfo<Movie>> in
            return self.useCase.getMoreMovie(type: self.moreMovie, page: page)
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
        }
        
        let loadOutput = getPage(loadTrigger: input.loadTrigger,
                                 reloadTrigger: input.reloadTrigger,
                                 loadMoreTrigger: input.loadMoreTrigger,
                                 getItems: getItems)
        let (page, error, indicator, refreshing, loadingMore) = loadOutput.destructured
        
        let movieList = page
            .map { $0.items }
        
        let selectedBack = input.backTrigger
            .do(onNext: self.navigator.back)
        
        return Output(getMore: movieList,
                      selectedBack: selectedBack,
                      error: error,
                      indicator: indicator,
                      refreshing: refreshing,
                      loadMore: loadingMore)
    }
}
