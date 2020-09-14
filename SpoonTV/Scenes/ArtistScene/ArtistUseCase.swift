//
//  ArtistUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

protocol ArtistUseCaseType {
    func getArtistList() -> Observable<PagingInfo<Artist>>
    func getMoreArtist(page: Int) -> Observable<PagingInfo<Artist>>
}

struct ArtistUseCase: ArtistUseCaseType {
    let repositories = ArtistRepositories()

    func getArtistList() -> Observable<PagingInfo<Artist>> {
        return getMoreArtist(page: 1)
    }
    
    func getMoreArtist(page: Int) -> Observable<PagingInfo<Artist>> {
        let request = ListArtistRequest(page: page)
        return repositories.getListArtistRepo(page: page, input: request)
    }
}
