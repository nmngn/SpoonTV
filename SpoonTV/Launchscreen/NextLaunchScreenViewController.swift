//
//  LaunchScreen2ViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 8/31/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class NextLaunchScreenViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    let bag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        scheduledTimerWithTimeInterval()
    }
    func scheduledTimerWithTimeInterval(){
        Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.animateScrollView), userInfo: nil, repeats: true)
    }
    
    @objc private func animateScrollView() {
        
        let scrollWidth = scrollView.bounds.width / 5
        let currentXOffset = scrollView.contentOffset.x
        let lastXPos = currentXOffset + scrollWidth
        let observable = Observable.just(lastXPos)
        
        observable
            .filter { $0 < 180 }
            .subscribe(onNext: { _ in
                self.scrollView.setContentOffset(CGPoint(x: lastXPos, y: 0), animated: true)
            })
            .disposed(by: bag)
        
    }
}
