//
//  ResultArtist.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

final class ResultArtist: Mappable {
    var resultArtist = [Artist]()
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        resultArtist <- map["results"]
    }
}
