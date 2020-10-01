//
//  ActorListInMovieRequest.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class ActorListInMovieRequest: BaseRequest {
    
    required init(id: Int) {
        let url = String(format: URLs.Movie.actorOfMovie, id)
        let body: [String: Any] = [:]
        super.init(url: url, requestType: .get, body: body)
    }
}
