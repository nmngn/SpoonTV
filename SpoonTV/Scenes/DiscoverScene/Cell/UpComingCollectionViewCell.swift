//
//  UpComingCollectionViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable

final class UpComingCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var upComingImage: UIImageView!
    @IBOutlet private weak var upComingTitle: UILabel!
    
    func setContent(_ upComing: UpComingMovie) {
        upComingImage.sd_setImage(with: URL(string: GetImage.getImage + upComing.posterPath), completed: nil)
        upComingImage.makeRound()
        upComingTitle.text = upComing.originalTitle
    }
}
