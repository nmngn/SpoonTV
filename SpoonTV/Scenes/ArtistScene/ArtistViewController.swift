//
//  ArtistViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture
import MGLoadMore

final class ArtistViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var collectionView: LoadMoreCollectionView!
    
    var viewModel: ArtistViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        collectionView.do {
            $0.register(cellType: ArtistCollectionViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = ArtistViewModel.Input(loadTrigger: Driver.just(()),
                                          reloadTrigger: collectionView.refreshTrigger,
                                          loadMoreTrigger: collectionView.loadMoreTrigger,
                                          selectTrigger: collectionView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
            output.getArtistList
                .drive(collectionView.rx.items) { (collectionView, indexPath, item) in
                    let cell = collectionView.dequeueReusableCell(
                        for: IndexPath(item: indexPath, section: 0),
                        cellType: ArtistCollectionViewCell.self)
                    cell.setContent(item)
                    return cell
                }
            .disposed(by: rx.disposeBag)
        
        output.selectedArtist
            .drive()
            .disposed(by: rx.disposeBag)
        output.isLoading
            .drive()
            .disposed(by: rx.disposeBag)
        output.isReloading
            .drive(collectionView.isRefreshing)
            .disposed(by: rx.disposeBag)
        output.isLoadingMore
            .drive(collectionView.isLoadingMore)
            .disposed(by: rx.disposeBag)
    }
}

extension ArtistViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "ArtistScene", bundle: nil)
}
