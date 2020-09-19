//
//  DiscoverUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/9/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import MGArchitecture

protocol DiscoverUseCaseType {
    func getPopularMovie() -> Observable<PagingInfo<Movie>>
    func getTopRatedMovie() -> Observable<PagingInfo<Movie>>
    func getUpComingMovie() -> Observable<PagingInfo<Movie>>
}

struct DiscoverUseCase: DiscoverUseCaseType {
 
    let repositories = MovieRepositories()
    
    func getPopularMovie() -> Observable<PagingInfo<Movie>> {
        let request = PopularRequest(page: 1)
        return repositories.getPopularRepo(page: 1, input: request)
    }
    
    func getTopRatedMovie() -> Observable<PagingInfo<Movie>> {
        let request = TopRatedRequest(page: 1)
        return repositories.getTopRatedRepo(page: 1, input: request)
    }
    
    func getUpComingMovie() -> Observable<PagingInfo<Movie>> {
        let request = UpComingRequest(page: 1)
        return repositories.getUpComingRepo(page: 1, input: request)
    }
}
