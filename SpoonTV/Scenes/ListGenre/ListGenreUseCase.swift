//
//  ListGenreUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import MGArchitecture
import RxSwift
import RxCocoa

protocol ListGenreUseCaseType {
    func getListGenre() -> Observable<PagingInfo<Movie>>
    func getMoreListGenre(page: Int) -> Observable<PagingInfo<Movie>>
}

struct ListGenreUseCase: ListGenreUseCaseType {
    let repositories = GenreRepositories()
    let movieId: Int
    
    func getListGenre() -> Observable<PagingInfo<Movie>> {
        getMoreListGenre(page: 1)
    }
    
    func getMoreListGenre(page: Int) -> Observable<PagingInfo<Movie>> {
        let request = SelectedGenreRequest(page: page, id: movieId)
        return repositories.getSelectedGenreRepo(page: page, input: request)
    }
}
