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

protocol DiscoverUseCaseType {
    func getPopularMovie() -> Observable<[PopularMovie]>
    func getTopRatedMovie() -> Observable<[TopRatedMovie]>
    func getUpComingMovie() -> Observable<[UpComingMovie]>
}

struct DiscoverUseCase: DiscoverUseCaseType {
 
    let repositories = MovieRepositories()
    
    func getPopularMovie() -> Observable<[PopularMovie]> {
        let request = PopularRequest(page: 1)
        return repositories.getPopularRepo(input: request)
    }
    
    func getTopRatedMovie() -> Observable<[TopRatedMovie]> {
        let request = TopRatedRequest(page: 1)
        return repositories.getTopRatedRepo(input: request)
    }
    
    func getUpComingMovie() -> Observable<[UpComingMovie]> {
        let request = UpComingRequest(page: 1)
        return repositories.getUpComingRepo(input: request)
    }
}
