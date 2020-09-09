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

protocol MovieRepositoriesType {
    func getPopularRepo(input: PopularRequest) -> Observable<[PopularMovie]>
    func getTopRatedRepo(input: TopRatedRequest) -> Observable<[TopRatedMovie]>
    func getUpComingRepo(input: UpComingRequest) -> Observable<[UpComingMovie]>
    func getDetailMovieRepo(input: DetailRequest) -> Observable<MovieDetail>
    func getSimilarMovieRepo(input: SimilarRequest) -> Observable<[SimilarMovie]>
}

final class MovieRepositories: MovieRepositoriesType {
    private let api = APIService.shared
    
    func getPopularRepo(input: PopularRequest) -> Observable<[PopularMovie]> {
        return api.request(input: input)
            .map {(response: ResultPopular) -> [PopularMovie] in
                return response.resultPopular
            }
    }
    
    func getTopRatedRepo(input: TopRatedRequest) -> Observable<[TopRatedMovie]> {
           return api.request(input: input)
               .map {(response: ResultToprated) -> [TopRatedMovie] in
                   return response.resultTopRated
               }
       }
    
    func getUpComingRepo(input: UpComingRequest) -> Observable<[UpComingMovie]> {
          return api.request(input: input)
              .map {(response: ResultUpComing) -> [UpComingMovie] in
                  return response.resultUpcoming
              }
      }
    
    func getDetailMovieRepo(input: DetailRequest) -> Observable<MovieDetail> {
        return api.request(input: input)
            .map {(response: MovieDetail) in
                return response
            }
    }
    
    func getSimilarMovieRepo(input: SimilarRequest) -> Observable<[SimilarMovie]> {
          return api.request(input: input)
              .map {(response: ResultSimilar) -> [SimilarMovie] in
                  return response.resultSimilar
              }
    }
}
