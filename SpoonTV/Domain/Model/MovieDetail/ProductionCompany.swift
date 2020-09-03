//
//  ProductionCompany.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProductionCompany: Mappable{
    var companyId = 0
    var companyName = ""
    var originCountry = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        companyId <- map["id"]
        companyName <- map["name"]
        originCountry <- map["origin_country"]
    }
}
