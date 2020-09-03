//
//  SceneDelegate.swift
//  SpoonTV
//
//  Created by Nam Ngây on 8/31/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        bindViewModel()
    }
    
    private func bindViewModel() {
        guard let window = window else { return }
        let navigator = AppNavigator(window: window)
        let useCase = AppUseCase()
        let viewModel = AppViewModel(navigator: navigator, useCase: useCase)
        
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        output.nextScreen
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
