//
//  ViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 8/31/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import Reusable
import MGArchitecture

final class MainViewController: UIViewController, BindableType {
    
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
    }
}

extension MainViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
}
