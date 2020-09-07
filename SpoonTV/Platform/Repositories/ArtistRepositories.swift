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

protocol ArtistRepositoriesType {
    func getListArtistRepo(input: ListArtistRequest) -> Observable<[Artist]>
    func getSelectedArtistRepo(input: SelectedArtistRequest ) -> Observable<ArtistDetail>
    func getMovieOfArtistRepo(input: MovieOfSeletedRequest) -> Observable<[MovieOfArtist]>
}

final class ArtistRepositories: ArtistRepositoriesType {
    private let api = APIService.shared
    
    func getListArtistRepo(input: ListArtistRequest) -> Observable<[Artist]> {
        return api.request(input: input)
            .map {(response: ResultArtist) -> [Artist] in
                return response.resultArtist
            }
    }
    
    func getSelectedArtistRepo(input: SelectedArtistRequest) -> Observable<ArtistDetail> {
        return api.request(input: input)
            .map {(response: ArtistDetail)  in
                return response
            }
    }
    
    func getMovieOfArtistRepo(input: MovieOfSeletedRequest) -> Observable<[MovieOfArtist]> {
        return api.request(input: input)
            .map {(response: ResultMovieArtist) -> [MovieOfArtist] in
                return  response.resultMovieArtist
            }
    }
}
