//
//  ArtistNavigator.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

protocol ArtistNavigatorType {
    func toDetailArtistScene(_ id: Int)
}

struct ArtistNavigator: ArtistNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toDetailArtistScene(_ id: Int) {
        
    }
}
