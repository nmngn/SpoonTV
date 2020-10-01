//
//  MovieDetail.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieDetail: Mappable {
    var adult = false
    var genres = [Genres]()
    var movieId = 0
    var originalTitle = ""
    var overview = ""
    var popularity = 0.0
    var backdropPath = ""
    var productionCompany = [ProductionCompany]()
    var productionCountry = [ProductionCountry]()
    var releaseDate = ""
    var runtime = 0
    var spokenLanguage = [SpokenLanguage]()
    var status = ""
    var tagline = ""
    var title = ""
    var voteAverage = 0.0
    var voteCount = 0
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        adult <- map["adult"]
        genres <- map["genres"]
        movieId <- map["id"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        backdropPath <- map["backdrop_path"]
        productionCompany <- map["production_companies"]
        productionCountry <- map["production_countries"]
        releaseDate <- map["release_date"]
        runtime <- map["runtime"]
        spokenLanguage <- map["spoken_languages"]
        status <- map["status"]
        tagline <- map["tagline"]
        title <- map["title"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        
    }
}
