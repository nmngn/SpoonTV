//
//  SeeMoreTableViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/19/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable

final class SeeMoreTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var seeMoreImage: UIImageView!
    @IBOutlet private weak var seeMoreLabel: UILabel!
    
    func setContent(_ item: Movie) {
        seeMoreImage.sd_setImage(with: URL(string: item.posterImageUrl), completed: nil)
        seeMoreImage.makeRound()
        seeMoreLabel.text = item.movieTitle
    }
}
