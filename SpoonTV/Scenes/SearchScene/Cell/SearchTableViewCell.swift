//
//  SearchTableViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/15/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class SearchTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var searchImage: UIImageView!
    @IBOutlet private weak var searchTitle: UILabel!
    
    func setContentForCell(data: SearchDataType) {
        switch data {
        case .movie(let movie):
            searchImage.sd_setImage(with: URL(string: GetImage.getImage + movie.moviePoster), completed: nil)
            searchImage.makeRound()
            searchTitle.text = movie.movieTitle
        case .artist(let artist):
            searchImage.sd_setImage(with: URL(string: GetImage.getImage + artist.artistProfilePath), completed: nil)
            searchImage.makeRound()
            searchTitle.text = artist.artistName
        }
    }
}
