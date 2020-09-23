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

enum SearchDataType {
    case movie(Movie)
    case artist(Artist)
}

protocol SearchUseCaseType {
    func getMoreSearchData(page: Int, query: String, type: Int) -> Observable<PagingInfo<SearchDataType>>
    func getSearchData(query: String, type: Int) -> Observable<PagingInfo<SearchDataType>>
}

struct SearchUseCase: SearchUseCaseType {
    let repositories = SearchRepositories()
    
    func getSearchData(query: String, type: Int) -> Observable<PagingInfo<SearchDataType>> {
        getMoreSearchData(page: 1, query: query, type: type)
    }
    
    func getMoreSearchData(page: Int, query: String, type: Int) -> Observable<PagingInfo<SearchDataType>> {
        switch type {
        case 0:
            let request = SearchForMovieRequest(query: query, page: page)
            return repositories.getSearchMovieRepo(page: page, input: request).map {
                let items = $0.items.map { SearchDataType.movie($0) }
                return PagingInfo(page: page, items: items)
            }
        default:
            let request = SearchForArtistRequest(query: query, page: page)
            return repositories.getSearchArtistRepo(page: page, input: request).map {
                let items = $0.items.map { SearchDataType.artist($0) }
                return PagingInfo(page: page, items: items)
            }
        }
    }
}
