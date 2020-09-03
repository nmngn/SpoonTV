//
//  GenresTabbar.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct GenresTabbar: Mappable {
    var genresId = 0
    var genresName = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        genresId <- map["id"]
        genresName <- map["name"]
    }
}
