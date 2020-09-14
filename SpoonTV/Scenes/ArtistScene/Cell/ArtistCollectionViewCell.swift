//
//  ArtistCollectionViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class ArtistCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var artistImage: UIImageView!
    @IBOutlet private weak var artistName: UILabel!
    
    func setContent(_ artist: Artist) {
        artistImage.sd_setImage(with: URL(string: GetImage.getImage + artist.artistProfilePath), completed: nil)
        artistImage.makeRound()
        artistName.text = artist.artistName
    }
}
