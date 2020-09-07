//
//  MovieOfSeletedRequest.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class MovieOfSeletedRequest: BaseRequest {
    
    required init(id: Int, page: Int) {
        let url = String(format: URLs.Artist.movieOfArtist, id)
        let body: [String: Any] = [
            "page": page
        ]
        super.init(url: url, requestType: .get, body: body)
    }
}
