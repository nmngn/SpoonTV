//
//  ListGenreTableViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/2/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable

final class ListGenreTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var nameMovie: UILabel!
    
    func setContent(_ movie: Movie) {
        imageMovie.sd_setImage(with: URL(string: movie.posterImageUrl), completed: nil)
        imageMovie.makeRound()
        nameMovie.text = movie.movieTitle
    }
}
