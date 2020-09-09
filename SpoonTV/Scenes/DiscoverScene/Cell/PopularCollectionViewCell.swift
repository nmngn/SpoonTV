//
//  PopularCollectionViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable

final class PopularCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var popularImage: UIImageView!
    @IBOutlet private weak var popularTitle: UILabel!
    
    func setContent(_ popular: PopularMovie) {
        popularImage.sd_setImage(with: URL(string: GetImage.getImage + popular.posterPath), completed: nil)
        popularImage.makeRound()
        popularTitle.text = popular.originalTitle
    }
}
