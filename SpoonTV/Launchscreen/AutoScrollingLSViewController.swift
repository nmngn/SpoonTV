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
import NSObject_Rx
import Reusable

final class AutoScrollingLSViewController: UIViewController{
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        scheduledTimerWithTimeInterval()
    }
    
    private func scheduledTimerWithTimeInterval(){
        let scrollWidth = scrollView.bounds.width / 5
        let currentXOffset = scrollView.contentOffset.x
        let lastXPos = currentXOffset + scrollWidth
        
        Observable<Int>.interval(.milliseconds(20), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.scrollView.setContentOffset(CGPoint(x: lastXPos, y: 0), animated: true)
            })
            .disposed(by: rx.disposeBag)
    }
}

extension AutoScrollingLSViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "AutoScrollingLS", bundle: nil)
}
