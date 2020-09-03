//
//  TopRatedMovie.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct TopRatedMovie {
    
    var movieId = 0
    var posterPath = ""
    var originalTitle = ""
    var overview = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        movieId <- map["id"]
        posterPath <- map["poster_path"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
    }
}
