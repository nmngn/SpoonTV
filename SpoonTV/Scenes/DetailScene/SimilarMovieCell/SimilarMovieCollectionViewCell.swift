//
//  SimilarMovieCollectionViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/24/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class SimilarMovieCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var movieImage: UIImageView!
    
    func setContent(_ movie: Movie) {
        movieImage.sd_setImage(with: URL(string: GetImage.getImage + movie.moviePoster), completed: nil)
        movieImage.makeRound()
    }
}
