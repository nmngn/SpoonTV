//
//  ActorCollectionViewCell.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class ActorCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var actorName: UILabel!
    
    func setContent(_ actor: ActorOfMovie) {
        avatarImage.sd_setImage(with: URL(string: actor.image), completed: nil)
        avatarImage.makeRound()
        actorName.text = actor.actorName
    }
}
