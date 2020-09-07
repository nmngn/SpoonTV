//
//  ListGenreRequest.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class ListGenreRequest: BaseRequest {
    
    required init(page: Int) {
        let body: [String: Any] = [
            "page": page
        ]
        super.init(url: URLs.Genres.list, requestType: .get, body: body)
    }
}
