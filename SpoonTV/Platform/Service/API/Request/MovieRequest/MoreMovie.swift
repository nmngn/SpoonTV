//
//  MoreMovie.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/21/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

enum MoreMovie: String {
    case popular
    case upComing = "upcoming"
    case topRated = "top_rated"
}

final class GetMoreMovieRequest: BaseRequest {
    required init(type: MoreMovie, page: Int) {
        let url = String(format: URLs.Movie.moreMovie, type.rawValue)
        let body = [
            "page": page
        ]
        super.init(url: url, requestType: .get, body: body)
        
    }
}
