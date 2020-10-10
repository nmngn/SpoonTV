//
//  ArtistDetailUseCase.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ArtistDetailUseCaselType {
    func getDetail() -> Observable<ArtistDetail>
    func getMovieOfArtist() -> Observable<[Movie]>
}

struct ArtistDetailUseCase: ArtistDetailUseCaselType {
    let repositories = ArtistRepositories()
    var artistId: Int
    
    func getDetail() -> Observable<ArtistDetail> {
        let request = SelectedArtistRequest(id: artistId)
        return repositories.getSelectedArtistRepo(input: request)
    }
    
    func getMovieOfArtist() -> Observable<[Movie]> {
        let request = MovieOfSeletedRequest(id: artistId, page: 1)
        return repositories.getMovieOfArtistRepo(input: request)
    }
}
