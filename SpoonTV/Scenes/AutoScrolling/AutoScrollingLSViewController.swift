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
import MGArchitecture
import Then

final class AutoScrollingLSViewController: UIViewController, BindableType {
    var viewModel: AutoScrollingViewModel!
    var navigation: UINavigationController?
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var nextButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configView()
        navigationController?.navigationBar.isHidden = true
    }
    
    func configView() {
        nextButton.do {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            $0.layer.shadowOpacity = 1.0
            $0.layer.shadowRadius = 0.0
            $0.layer.masksToBounds = false
            $0.layer.cornerRadius = $0.frame.height / 5
            $0.tapAnimation($0)
        }
        scheduledTimerWithTimeInterval()
    }
    
    private func scheduledTimerWithTimeInterval() {
        let scrollWidth = scrollView.bounds.width / 5
        let currentXOffset = scrollView.contentOffset.x
        let lastXPos = currentXOffset + scrollWidth
        
        Observable<Int>.interval(.milliseconds(20), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.scrollView.isScrollEnabled = false
                self.scrollView.setContentOffset(CGPoint(x: lastXPos, y: 0), animated: true)
                if self.scrollView.contentOffset.x > 60 {
                    self.nextButton.isHidden = false
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        let input = AutoScrollingViewModel.Input(loadTrigger:
            nextButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.toMain
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension AutoScrollingLSViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "AutoScrollingLS", bundle: nil)
}
