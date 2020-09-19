//
//  SeeMoreUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/19/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MGArchitecture

protocol SeeMoreUseCaseType {
    func getMoreMovie(type: MoreMovie, page: Int) -> Observable<PagingInfo<Movie>>
    func getMore(type: MoreMovie) -> Observable<PagingInfo<Movie>>
}

struct SeeMoreUseCase: SeeMoreUseCaseType {
    let repositories = MovieRepositories()

    func getMoreMovie(type: MoreMovie, page: Int) -> Observable<PagingInfo<Movie>> {
        let request = GetMoreMovieRequest(type: type, page: page)
        return repositories.getMoreMovie(type: type, page: page, input: request)
    }
    func getMore(type: MoreMovie) -> Observable<PagingInfo<Movie>> {
        getMoreMovie(type: type, page: 1)
    }
}
