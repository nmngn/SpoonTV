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
    func getMovieResult(query: String) -> Observable<PagingInfo<Movie>>
    func getArtistResult(query: String) -> Observable<PagingInfo<Artist>>
    func getMoreMovie(page: Int, query: String) -> Observable<PagingInfo<Movie>>
    func getMoreArtist(page: Int, query: String) -> Observable<PagingInfo<Artist>>
}

struct SearchUseCase: SearchUseCaseType {
    let repositories = SearchRepositories()
    
    func getMovieResult(query: String) -> Observable<PagingInfo<Movie>> {
        getMoreMovie(page: 1, query: query)
    }
    
    func getArtistResult(query: String) -> Observable<PagingInfo<Artist>> {
        getMoreArtist(page: 1, query: query)
        
    }
    
    func getMoreMovie(page: Int, query: String) -> Observable<PagingInfo<Movie>> {
        let request = SearchForMovieRequest(query: query, page: page)
        return repositories.getSearchMovieRepo(page: page, input: request)
    }
    
    func getMoreArtist(page: Int, query: String) -> Observable<PagingInfo<Artist>> {
        let request = SearchForArtistRequest(query: query, page: page)
        return repositories.getSearchArtistRepo(page: page, input: request)
    }
}
