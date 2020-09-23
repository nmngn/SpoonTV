//
//  SearchRepositories.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import MGArchitecture

protocol SearchRepositorriesType {
    func getSearchMovieRepo(page: Int, input: SearchForMovieRequest) -> Observable<PagingInfo<Movie>>
    func getSearchArtistRepo(page: Int, input: SearchForArtistRequest) -> Observable<PagingInfo<Artist>>
}

final class SearchRepositories: SearchRepositorriesType {
    private let api = APIService.shared
    
    func getSearchMovieRepo(page: Int, input: SearchForMovieRequest) -> Observable<PagingInfo<Movie>> {
        return api.request(input: input)
            .map {(response: ResultSearchMovie) in
                return PagingInfo(page: page, items: response.resultSearchMovie)
            }
    }
    
    func getSearchArtistRepo(page: Int, input: SearchForArtistRequest) -> Observable<PagingInfo<Artist>> {
        return api.request(input: input)
            .map {(response: ResultSearchArtist) in
                return PagingInfo(page: page, items: response.resultSearchArtist)
            }
    }
}
