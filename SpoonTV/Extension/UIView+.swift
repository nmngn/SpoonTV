//
//  UIView+.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/3/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

extension UIView {
    func tapAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        }, completion: { _ in }
        )
    }
    
    func makeRound() {
        layer.cornerRadius = frame.height / 20
    }
}
