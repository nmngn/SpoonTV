//
//  SimilarMovie.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct SimilarMovie: Mappable {
    var originalTitle = ""
    var similarId = 0
    var posterPath = ""
    var overview = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        originalTitle <- map["original_title"]
        similarId <- map["id"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
    }
}
