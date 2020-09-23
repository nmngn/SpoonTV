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
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.rowHeight = 125
        }
    }
    
    func bindViewModel() {
        let input = ViewModelType.Input(textSearch: searchBar.rx.text.orEmpty.asDriver(),
                                        loadTrigger: Driver.just(()),
                                        reloadTrigger: tableView.refreshTrigger,
                                        loadMoreTrigger: tableView.loadMoreTrigger,
                                        selectTrigger: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
    
        output.searchMovie
            .filter { _ in
                self.segmentedControl.selectedSegmentIndex == 0
            }
        .drive(tableView.rx.items) { tableView, index, item in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchTableViewCell.self)
            cell.setContent(item, nil, self.segmentedControl.selectedSegmentIndex)
            return cell
        }
        .disposed(by: rx.disposeBag)
        
        output.searchArtist
            .filter { _ in
                self.segmentedControl.selectedSegmentIndex == 1
            }
        .drive(tableView.rx.items) { tableView, index, item in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchTableViewCell.self)
            cell.setContent(nil, item, self.segmentedControl.selectedSegmentIndex)
            return cell
        }
        .disposed(by: rx.disposeBag)
        
        output.isLoading
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isLoadingMore
            .drive(tableView.isLoadingMore)
            .disposed(by: rx.disposeBag)
    }
}

extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "SearchScene", bundle: nil)
}
