//
//  GenreViewController.swift
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

final class GenreViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: GenreViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tableView.do {
            $0.register(cellType: GenreTableViewCell.self)
            $0.rowHeight = Constant.heightForRow
        }
    }
    
    func bindViewModel() {
        let input = GenreViewModel.Input(loadTrigger: Driver.just(()),
                                         selectTrigger: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
        output.getGenre
            .drive(tableView.rx.items) { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(
                    for: IndexPath(item: indexPath, section: 0),
                    cellType: GenreTableViewCell.self)
                cell.setContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.selectedGenre
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension GenreViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "GenreScene", bundle: nil)
}
