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

protocol SearchRepositorriesType {
    func getSearchMovieRepo(input: SearchForMovieRequest) -> Observable<[SearchMovie]>
    func getSearchArtistRepo(input: SearchForArtistRequest) -> Observable<[SearchArtist]>
}

final class SearchRepositories: SearchRepositorriesType {
    private let api = APIService.shared
    
    func getSearchMovieRepo(input: SearchForMovieRequest) -> Observable<[SearchMovie]> {
        return api.request(input: input)
            .map {(response: ResultSearchMovie) -> [SearchMovie] in
                return response.resultSearchMovie
            }
    }
    
    func getSearchArtistRepo(input: SearchForArtistRequest) -> Observable<[SearchArtist]> {
        return api.request(input: input)
            .map {(response: ResultSearchArtist) -> [SearchArtist] in
                return response.resultSearchArtist
            }
    }
}
