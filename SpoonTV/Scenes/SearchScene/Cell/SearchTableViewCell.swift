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
    
    func setContentForCell(data: Movie) {
        searchImage.sd_setImage(with: URL(string: GetImage.getImage + data.moviePoster), completed: nil)
        searchImage.makeRound()
        searchTitle.text = data.movieTitle
    }
}
