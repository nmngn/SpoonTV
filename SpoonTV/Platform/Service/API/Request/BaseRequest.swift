//
//  BaseRequest.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/4/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest {
    
    var url = ""
    var requestType = Alamofire.HTTPMethod.get
    var body: [String: Any]?
    
    init(url: String) {
        self.url = url
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod) {
        self.url = url
        self.requestType = requestType
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod, body: [String: Any]?) {
        self.url = url
        self.requestType = requestType
        self.body = body
    }
    
    var encoding: ParameterEncoding {
        switch requestType {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
