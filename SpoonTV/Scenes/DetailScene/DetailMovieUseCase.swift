//
//  DetailMovieUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/22/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import RxCocoa
import RxSwift
import MGArchitecture

protocol DetailMovieUseCaseType {
    func getDetailMovie() -> Observable<MovieDetail>
    func getSimilarMovie() -> Observable<[Movie]>
    func getActor() -> Observable<[ActorOfMovie]>
}

struct DetailMovieUseCase: DetailMovieUseCaseType {
    
    let repositories = MovieRepositories()
    let movieId: Int
    
    func getDetailMovie() -> Observable<MovieDetail> {
        let request = DetailRequest(id: movieId)
        return repositories.getDetailMovieRepo(input: request)
    }
    
    func getSimilarMovie() -> Observable<[Movie]> {
         let request = SimilarRequest(id: movieId, page: 1)
        return repositories.getSimilarMovieRepo(input: request)
     }
    
    func getActor() -> Observable<[ActorOfMovie]> {
        let request = ActorListInMovieRequest(id: movieId)
        return repositories.getActorInMovieRepo(input: request)
    }
}
