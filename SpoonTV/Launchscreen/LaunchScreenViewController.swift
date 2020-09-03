//
//  LaunchScreenViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.isHidden = true
        changeScreen(after: 1.5)
    }
    func changeScreen(after delay: Double) {
        let autoScrollingVC = AutoScrollingLSViewController.instantiate()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.navigationController?.pushViewController(autoScrollingVC, animated: true)
        }
    }
}
