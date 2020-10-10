//
//  MovieCollectionViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Reusable

final class MovieCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var imageMovie: UIImageView!
    
    func setContent(_ item: Movie) {
        imageMovie.sd_setImage(with: URL(string: item.posterImageUrl), completed: nil)
        imageMovie.makeRound()
    }

}
