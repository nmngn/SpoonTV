//
//  SearchForMovieRequest.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class SearchForMovieRequest: BaseRequest {
    
    required init(query: String, page: Int) {
        let url = String(format: URLs.Search.movie, query)
        let body: [String: Any] = [
            "query": query,
            "page": page
        ]
        super.init(url: url, requestType: .get, body: body)
    }
}
