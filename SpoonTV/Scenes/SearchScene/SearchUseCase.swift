//
//  SearchUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/15/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import MGArchitecture
import RxSwift
import RxCocoa

protocol SearchUseCaseType {
    func getMoreSearchData(page: Int, query: String) -> Observable<PagingInfo<Movie>>
    func getSearchData(query: String) -> Observable<PagingInfo<Movie>>
}

struct SearchUseCase: SearchUseCaseType {
    let repositories = SearchRepositories()
    
    func getSearchData(query: String) -> Observable<PagingInfo<Movie>> {
        getMoreSearchData(page: 1, query: query)
    }
    
    func getMoreSearchData(page: Int, query: String) -> Observable<PagingInfo<Movie>> {
        let request = SearchForMovieRequest(query: query, page: page)
        return repositories.getSearchMovieRepo(page: page, input: request)
    }
}
