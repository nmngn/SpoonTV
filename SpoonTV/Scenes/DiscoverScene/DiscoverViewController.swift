//
//  DiscoverViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/9/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture
import RxDataSources

final class DiscoverViewController: UIViewController, BindableType, Reusable {
    
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    @IBOutlet private weak var topRatedCollectionView: UICollectionView!
    @IBOutlet private weak var upComingCollectionView: UICollectionView!
    @IBOutlet private weak var seeMorePopular: UIButton!
    @IBOutlet private weak var seeMoreTopRated: UIButton!
    @IBOutlet private weak var seeMoreUpComing: UIButton!
    
    var viewModel: DiscoverViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        popularCollectionView.do {
            $0.register(cellType: PopularCollectionViewCell.self)
        }
        topRatedCollectionView.do {
            $0.register(cellType: TopRatedCollectionViewCell.self)
        }
        upComingCollectionView.do {
            $0.register(cellType: UpComingCollectionViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = DiscoverViewModel.Input(loadTrigger: Driver.just(()),
                                            selectTrigger: Driver.merge(
                                                popularCollectionView.rx.itemSelected.asDriver(),
                                                topRatedCollectionView.rx.itemSelected.asDriver(),
                                                upComingCollectionView.rx.itemSelected.asDriver()),
                                            morePopularTrigger: seeMorePopular.rx.tap.asDriver(),
                                            moreTopRatedTrigger: seeMoreTopRated.rx.tap.asDriver(),
                                            moreUpComingTrigger: seeMoreUpComing.rx.tap.asDriver())
        let output = viewModel.transfrom(input)
        
        output.error
            .drive(onNext: {
                print("Error: \($0)")
            })
            .disposed(by: rx.disposeBag)
        
        output.popularMovie
            .drive(popularCollectionView.rx.items) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(
                    for: IndexPath(item: indexPath, section: 0),
                    cellType: PopularCollectionViewCell.self)
                cell.setContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.topRatedMovie
            .drive(topRatedCollectionView.rx.items) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(
                    for: IndexPath(item: indexPath, section: 0),
                    cellType: TopRatedCollectionViewCell.self)
                cell.getContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.upComingMovie
            .drive(upComingCollectionView.rx.items) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(
                    for: IndexPath(item: indexPath, section: 0),
                    cellType: UpComingCollectionViewCell.self)
                cell.setContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.morePopular
            .drive()
            .disposed(by: rx.disposeBag)
        output.moreTopRated
            .drive()
            .disposed(by: rx.disposeBag)
        output.moreUpcoming
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension DiscoverViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "DiscoverScene", bundle: nil)
}
