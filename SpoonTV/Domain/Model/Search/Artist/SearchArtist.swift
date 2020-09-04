//
//  SearchArtist.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchArtist: Mappable {
    
    var artistName = ""
    var artistId = 0
    var artistProfilePath = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        artistId <- map["id"]
        artistName <- map["name"]
        artistProfilePath <- map["profile_path"]
    }
}
