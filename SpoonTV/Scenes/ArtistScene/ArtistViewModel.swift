//
//  ArtistViewModel.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MGArchitecture

struct ArtistViewModel {
    let navigator: ArtistNavigatorType
    let useCase: ArtistUseCaseType
}

extension ArtistViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    struct Output {
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let isLoadingMore: Driver<Bool>
        let getArtistList: Driver<[Artist]>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()

        let getItems = { (page: Int) -> Observable<PagingInfo<Artist>> in
            self.useCase.getMoreArtist(page: page)
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
        }
        
        let loadOutput = getPage(loadTrigger: input.loadTrigger,
                                 reloadTrigger: input.reloadTrigger,
                                 loadMoreTrigger: input.loadMoreTrigger,
                                 getItems: getItems)
        
        let (page, error, isLoading, isReloading, isLoadingMore) = loadOutput.destructured
        
        let artists = page.map { $0.items }
        
        return Output(error: Driver.merge(error.asDriver(), errorTracker.asDriver()),
                      isLoading: isLoading,
                      isReloading: isReloading,
                      isLoadingMore: isLoadingMore,
                      getArtistList: artists)
    }
}
