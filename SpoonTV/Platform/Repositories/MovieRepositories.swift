//
//  MovieRepositories.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import MGArchitecture

protocol MovieRepositoriesType {
    func getPopularRepo(page: Int, input: PopularRequest) -> Observable<PagingInfo<Movie>>
    func getTopRatedRepo(page: Int, input: TopRatedRequest) -> Observable<PagingInfo<Movie>>
    func getUpComingRepo(page: Int, input: UpComingRequest) -> Observable<PagingInfo<Movie>>
    func getDetailMovieRepo(input: DetailRequest) -> Observable<MovieDetail>
    func getSimilarMovieRepo(input: SimilarRequest) -> Observable<[Movie]>
    func getMoreMovie(type: MoreMovie, page: Int, input: GetMoreMovieRequest) -> Observable<PagingInfo<Movie>>
    func getActorInMovieRepo(input: ActorListInMovieRequest) -> Observable<[ActorOfMovie]>
}

final class MovieRepositories: MovieRepositoriesType {
    
    private let api = APIService.shared
    
    func getPopularRepo(page: Int, input: PopularRequest) -> Observable<PagingInfo<Movie>> {
        return api.request(input: input)
            .map {(response: MovieResponse) in
                return PagingInfo(page: page, items: response.resultMovie)
            }
    }
    
    func getTopRatedRepo(page: Int, input: TopRatedRequest) -> Observable<PagingInfo<Movie>> {
        return api.request(input: input)
            .map {(response: MovieResponse) in
                return PagingInfo(page: page, items: response.resultMovie)
            }
    }
    
    func getUpComingRepo(page: Int, input: UpComingRequest) -> Observable<PagingInfo<Movie>> {
        return api.request(input: input)
            .map {(response: MovieResponse) in
                return PagingInfo(page: page, items: response.resultMovie)
            }
    }
    
    func getDetailMovieRepo(input: DetailRequest) -> Observable<MovieDetail> {
        return api.request(input: input)
            .map {(response: MovieDetail) in
                return response
            }
    }
    
    func getSimilarMovieRepo(input: SimilarRequest) -> Observable<[Movie]> {
        return api.request(input: input)
            .map {(response: SimilarResponse) -> [Movie] in
                return response.resultSimilar
            }
    }
    
    func getMoreMovie(type: MoreMovie, page: Int, input: GetMoreMovieRequest) -> Observable<PagingInfo<Movie>> {
        let request = GetMoreMovieRequest(type: type, page: page)
        return api.request(input: request)
            .map {(response: MovieResponse) in
                return PagingInfo(page: page, items: response.resultMovie)
            }
    }
    
    func getActorInMovieRepo(input: ActorListInMovieRequest) -> Observable<[ActorOfMovie]> {
        return api.request(input: input)
            .map {(response: ActorInMovieResponse) in
                return response.resultActor
            }
    }
}
