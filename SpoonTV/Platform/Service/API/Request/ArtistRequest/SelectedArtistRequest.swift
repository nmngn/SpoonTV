//
//  SelectedArtistRequest.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class SelectedArtistRequest: BaseRequest {
    
    required init(id: Int) {
        let url = String(format: URLs.Artist.selected, id)
        let body: [String: Any] = [:]
        super.init(url: url, requestType: .get, body: body)
    }
}
