//
//  ActorInMovieResponse.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

final class ActorInMovieResponse: Mappable {
    var resultActor = [ActorOfMovie]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        resultActor <- map["cast"]
    }
}
