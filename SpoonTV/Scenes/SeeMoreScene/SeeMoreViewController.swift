//
//  SeeMoreViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/19/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture
import MGLoadMore

final class SeeMoreViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var tableView: LoadMoreTableView!
    @IBOutlet private weak var backButton: UIButton!
    
    var viewModel: SeeMoreViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tableView.do {
            $0.register(cellType: SeeMoreTableViewCell.self)
            $0.rowHeight = Constant.rowHeight
        }
    }
    func bindViewModel() {
        let input = SeeMoreViewModel.Input(loadTrigger: Driver.just(()),
                                           reloadTrigger: tableView.refreshTrigger,
                                           loadMoreTrigger: tableView.loadMoreTrigger,
                                           backTrigger: backButton.rx.tap.asDriver(),
                                           selectTrigger: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
         
        output.getMore
            .drive(tableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SeeMoreTableViewCell.self)
                cell.setContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.selectedBack
            .drive()
            .disposed(by: rx.disposeBag)
        output.loadMore
            .drive(tableView.isLoadingMore)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(tableView.isRefreshing)
            .disposed(by: rx.disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension SeeMoreViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "SeeMoreScene", bundle: nil)
}
