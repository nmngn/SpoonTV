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
    
    func setContent(_ movies: Movie?, _ artist: Artist?, _ index: Int ) {
        switch index {
        case 0:
            searchImage.sd_setImage(with: URL(string: GetImage.getImage + (movies?.moviePoster ?? "")),
                                    completed: nil)
            searchImage.makeRound()
            searchTitle.text = movies?.movieTitle
        default:
            searchImage.sd_setImage(with: URL(string: GetImage.getImage + (artist?.artistProfilePath ?? "")),
                                    completed: nil)
            searchImage.makeRound()
            searchTitle.text = artist?.artistName
        }
        
    }
}
