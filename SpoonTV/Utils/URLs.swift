//
//  URLs.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

enum URLs {
    private static var url = "https://api.themoviedb.org/3"
    
    enum Movie {
        static let popular = url + "/movie/popular?language=en-US"
        static let topRated = url + "/movie/top_rated?language=en-US"
        static let upComing = url + "/movie/upcoming?language=en-US"
        static let detail = url + "/movie/%d?language=en-US"
        static let similar = url + "/movie/%d/similar?language=en-US"
        static let moreMovie = url + "/movie/%@?language=en-US"
        static let actorOfMovie = url + "/movie/%d/casts?language=en-US"
    }
    
    enum Genres {
        static let list = url + "/genre/movie/list?language=en-US"
        static let selected = url + "/discover/movie?with_genres=%d&language=en-US&sort_by=popularity.desc"
    }

    enum Artist {
        static let list = url + "/person/popular?language=en-US"
        static let selected = url + "/person/%d?language=en-US"
        static let movieOfArtist = url + "/discover/movie?with_people=%d?language=en-US"
    }
    
    enum Search {
        static let movie = url + "/search/movie?query=%@&language=en-US"
        static let artist = url + "/search/person?query=%@&language=en-US"
    }
}

enum GetImage {
    private static var url = "https://image.tmdb.org/t/p/w500"
    
    static let getImage = url + "/"
}
