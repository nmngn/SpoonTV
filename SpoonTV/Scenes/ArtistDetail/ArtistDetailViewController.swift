//
//  ArtistDetailViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture

final class ArtistDetailViewController: UIViewController, BindableType {

    @IBOutlet private weak var artistImage: UIImageView!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var artistBirth: UILabel!
    @IBOutlet private weak var artistDepartment: UILabel!
    @IBOutlet private weak var artistGender: UILabel!
    @IBOutlet private weak var artistPlace: UILabel!
    @IBOutlet private weak var artistSummary: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: ArtistDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        collectionView.do {
            $0.register(cellType: MovieCollectionViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = ArtistDetailViewModel.Input(loadTrigger: Driver.just(()),
                                                reloadTrigger: Driver.just(()),
                                                selectTrigger: collectionView.rx.itemSelected.asDriver(),
                                                backTrigger: backButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input)
        
       output.getMovie
            .drive(collectionView.rx.items) { collectionView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
                cell.setContent(item)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.toDetailScene
            .drive()
            .disposed(by: rx.disposeBag)
        output.getDetail
            .drive(self.rx.artistDetail)
            .disposed(by: rx.disposeBag)
        output.selectedback
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension ArtistDetailViewController {
    func setContent(_ item: ArtistDetail) {
        artistImage.sd_setImage(with: URL(string: GetImage.getImage + item.profilePath), completed: nil)
        artistName.text = item.name
        artistBirth.text = item.birthday
        artistPlace.text = item.placeOfBirth
        if item.gender == 1 {
            artistGender.text = "Female"
        } else {
            artistGender.text = "Male"
        }
        artistDepartment.text = item.knownFor
        artistSummary.text = item.biography
        artistSummary.isEditable = false
    }
}

extension Reactive where Base: ArtistDetailViewController {
    var artistDetail: Binder<ArtistDetail> {
        return Binder(self.base) { controller, detail in
            controller.setContent(detail)
        }
    }
}
extension ArtistDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "ArtistDetail", bundle: nil)
}
