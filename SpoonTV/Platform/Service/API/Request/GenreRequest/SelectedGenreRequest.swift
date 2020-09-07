//
//  SelectedGenreRequest.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class SelectedGenreRequest: BaseRequest {
    
    required init(page: Int) {
        let url = String(format: URLs.Genres.selected)
        let body: [String: Any] = [
            "page": page
        ]
        super.init(url: url, requestType: .get, body: body)
    }
}
