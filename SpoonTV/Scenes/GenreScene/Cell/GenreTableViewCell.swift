//
//  GenreTableViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Reusable

final class GenreTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var genreImage: UIImageView!
    @IBOutlet private weak var genreTitle: UILabel!
    
    func setContent(_ genre: GenreTabbar) {
        genreTitle.text = genre.genreName
        genreImage.makeRound()
        genreImage.image = genre.genreImage
    }
}
