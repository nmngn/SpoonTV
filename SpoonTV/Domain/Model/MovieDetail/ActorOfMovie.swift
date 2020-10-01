//
//  ActorOfMovie.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import ObjectMapper

struct ActorOfMovie: Mappable {
    var actorName = ""
    var actorImage = ""
    var image: String {
        return GetImage.getImage + actorImage
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        actorName <- map["name"]
        actorImage <- map["profile_path"]
    }
    
}
