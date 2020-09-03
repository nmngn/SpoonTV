//
//  ArtistDetail.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct ArtistDetail: Mappable {
    
    var birthday = ""
    var knownFor = ""
    var artistId = 0
    var name = ""
    var gender = 0
    var biography = ""
    var popularity = 0.0
    var placeOfBirth = ""
    var profilePath = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        birthday <- map["birthday"]
        knownFor <- map["known_for_department"]
        artistId <- map["id"]
        name <- map["name"]
        gender <- map["gender"]
        biography <- map["biography"]
        popularity <- map["popularity"]
        placeOfBirth <- map["place_of_birth"]
        profilePath <- map["profile_path"]
    }
    
}
