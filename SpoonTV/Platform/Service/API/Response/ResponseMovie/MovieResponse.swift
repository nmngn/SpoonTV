//
//  ResultMovie.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/21/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

final class MovieResponse: Mappable {
    var resultMovie = [Movie]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        resultMovie <- map["results"]
    }
}
