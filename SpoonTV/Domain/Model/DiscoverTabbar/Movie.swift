//
//  Movies.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/21/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import ObjectMapper

struct Movie: Mappable {
    var movieId = 0
    var movieTitle = ""
    var moviePoster = ""
    var posterImageUrl: String {
        return GetImage.getImage + moviePoster
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        movieId <- map["id"]
        movieTitle <- map["title"]
        moviePoster <- map["poster_path"]
    }
}
