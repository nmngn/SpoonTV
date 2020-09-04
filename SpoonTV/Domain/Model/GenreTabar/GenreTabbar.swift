//
//  GenreTabbar.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct GenreTabbar: Mappable {
    var genreId = 0
    var genreName = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        genreId <- map["id"]
        genreName <- map["name"]
    }
}
