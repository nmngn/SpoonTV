//
//  GenreUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol GenreUseCaseType {
    func getGenre() -> Observable<[GenreTabbar]>
}

struct GenreUseCase: GenreUseCaseType {
    let repositories = GenreRepositories()

    func getGenre() -> Observable<[GenreTabbar]> {
        let request = ListGenreRequest()
        return repositories.getListGenreRepo(input: request)
    }
}
