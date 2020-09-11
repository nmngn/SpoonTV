//
//  GenreTabbar.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import ObjectMapper

struct GenreTabbar: Mappable {
    var genreId = 0
    var genreName = ""
    var genreImage = UIImage(named: "")
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        genreId <- map["id"]
        genreName <- map["name"]
        
        switch genreName {
        case "Action":
            genreImage = UIImage(named: "action")
        case "Adventure":
            genreImage = UIImage(named: "adventure")
        case "Animation":
            genreImage = UIImage(named: "anime")
        case "Comedy":
            genreImage = UIImage(named: "comedy")
        case "Crime":
            genreImage = UIImage(named: "crime")
        case "Documentary":
            genreImage = UIImage(named: "documentary")
        case "Drama":
            genreImage = UIImage(named: "drama")
        case "Family":
            genreImage = UIImage(named: "family")
        case "Fantasy":
            genreImage = UIImage(named: "fantasy")
        case "History":
            genreImage = UIImage(named: "history")
        case "Horror":
            genreImage = UIImage(named: "it")
        case "Music":
            genreImage = UIImage(named: "music")
        case "Mystery":
            genreImage = UIImage(named: "mystery")
        case "Romance":
            genreImage = UIImage(named: "romance")
        case "Science Fiction":
            genreImage = UIImage(named: "science")
        case "TV Movie":
            genreImage = UIImage(named: "tv movie")
        case "Thriller":
            genreImage = UIImage(named: "thriller")
        case "War":
            genreImage = UIImage(named: "war")
        case "Western":
            genreImage = UIImage(named: "western")
        default:
            break
        }
    }
}
