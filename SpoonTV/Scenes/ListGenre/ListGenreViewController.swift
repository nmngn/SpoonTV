//
//  ListGenreViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture
import MGLoadMore

final class ListGenreViewController: UIViewController, BindableType {

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var tableView: LoadMoreTableView!
    
    var viewModel: ListGenreViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tableView.do {
            $0.register(cellType: ListGenreTableViewCell.self)
            $0.rowHeight = Constant.rowHeight
        }
    }
    
    func bindViewModel() {
        let input = ListGenreViewModel.Input(loadTrigger: Driver.just(()),
                                             reloadTrigger: tableView.refreshTrigger,
                                             loadMoreTrigger: tableView.loadMoreTrigger,
                                             selectBackTrigger: backButton.rx.tap.asDriver(),
                                             selectMovieTrigger: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
        output.getListGenre
            .drive(tableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ListGenreTableViewCell.self)
                cell.setContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedBack
            .drive()
            .disposed(by: rx.disposeBag)
        output.isLoadingMore
            .drive(tableView.isLoadingMore)
            .disposed(by: rx.disposeBag)
        output.isReloading
            .drive(tableView.isRefreshing)
            .disposed(by: rx.disposeBag)
    }
}

extension ListGenreViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "ListGenre", bundle: nil)
}
