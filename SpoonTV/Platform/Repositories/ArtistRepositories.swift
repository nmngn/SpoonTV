//
//  ArtistRepositories.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import MGArchitecture

protocol ArtistRepositoriesType {
    func getListArtistRepo(page: Int, input: ListArtistRequest) -> Observable<PagingInfo<Artist>>
    func getSelectedArtistRepo(input: SelectedArtistRequest ) -> Observable<ArtistDetail>
    func getMovieOfArtistRepo(input: MovieOfSeletedRequest) -> Observable<[MovieOfArtist]>
}

final class ArtistRepositories: ArtistRepositoriesType {
    private let api = APIService.shared
    
    func getListArtistRepo(page: Int, input: ListArtistRequest) -> Observable<PagingInfo<Artist>> {
        return api.request(input: input)
            .map { (response: ResultArtist) in
                return PagingInfo(page: page,
                                  items: response.resultArtist,
                                  hasMorePages: true)
            }
    }
    
    func getSelectedArtistRepo(input: SelectedArtistRequest) -> Observable<ArtistDetail> {
        return api.request(input: input)
            .map { $0 }
    }
    
    func getMovieOfArtistRepo(input: MovieOfSeletedRequest) -> Observable<[MovieOfArtist]> {
        return api.request(input: input)
            .map {(response: ResultMovieArtist) -> [MovieOfArtist] in
                return  response.resultMovieArtist
            }
    }
    
}
