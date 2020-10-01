//
//  SearchViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/15/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture
import MGLoadMore

final class SearchViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: LoadMoreTableView!
    
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.rowHeight = Constant.rowHeight
            $0.tableFooterView = UIView()
        }
    }
    
    func bindViewModel() {
        let input = ViewModelType.Input(textSearch: searchBar.rx.text.orEmpty.asDriver(),
                                        loadTrigger: Driver.just(()),
                                        reloadTrigger: tableView.refreshTrigger,
                                        loadMoreTrigger: tableView.loadMoreTrigger,
                                        selectMovieTrigger: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
        
        output.dataSearch
            .drive(self.tableView.rx.items) { tableView, index, item in
                    let indexPath = IndexPath(item: index, section: 0)
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchTableViewCell.self)
                    cell.setContentForCell(data: item)
                    return cell
            }
            .disposed(by: self.rx.disposeBag)
        
        output.isLoading
            .drive()
            .disposed(by: rx.disposeBag)
        output.isLoadingMore
            .drive(tableView.isLoadingMore)
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyInput
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "SearchScene", bundle: nil)
}
