//
//  TopRatedCollectionViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable

final class TopRatedCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var topRatedImage: UIImageView!
    @IBOutlet private weak var topRatedTitle: UILabel!
    
    func getContent(_ topRated: TopRatedMovie) {
        topRatedImage.sd_setImage(with: URL(string: GetImage.getImage + topRated.posterPath), completed: nil)
        topRatedImage.makeRound()
        topRatedTitle.text = topRated.originalTitle
    }
}
