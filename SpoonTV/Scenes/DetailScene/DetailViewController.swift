//
//  DetailViewController.swift
//  SpoonTV
//
//  Created by Nam Ngây on 9/22/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable
import MGArchitecture

final class DetailViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var titleMovieLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UITextView!
    @IBOutlet private weak var tagLineLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var adultLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var voteCountLabel: UILabel!
    @IBOutlet private weak var runTimeLabel: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var actorCollectionView: UICollectionView!
    @IBOutlet private weak var similarMovieCollectionView: UICollectionView!
    
    var viewModel: DetailMovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        similarMovieCollectionView.do {
            $0.register(cellType: SimilarMovieCollectionViewCell.self)
        }
        actorCollectionView.do {
            $0.register(cellType: ActorCollectionViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = DetailMovieViewModel.Input(loadTrigger: Driver.just(()),
                                               reloadTrigger: Driver.just(()),
                                               selectTrigger: Driver.merge(
                                                similarMovieCollectionView.rx.itemSelected.asDriver(),
                                                actorCollectionView.rx.itemSelected.asDriver()),
                                               backTrigger: backButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input)
        
        output.getSimilar
            .drive(similarMovieCollectionView.rx.items) { collectionView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: SimilarMovieCollectionViewCell.self)
                cell.setContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.getActor
            .drive(actorCollectionView.rx.items) { collectionView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: ActorCollectionViewCell.self)
                cell.setContent(item)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        output.getDetail
            .drive(self.rx.movieDetail)
            .disposed(by: rx.disposeBag)
        output.selectedBack
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension DetailViewController {
    func setContent(_ item: MovieDetail) {
        imageMovie.sd_setImage(with: URL(string: GetImage.getImage + item.backdropPath), completed: nil)
        titleMovieLabel.text = item.originalTitle
        overviewLabel.text = item.overview
        overviewLabel.isEditable = false
        if item.tagline.isEmpty {
            tagLineLabel.text = " Do you know \(item.title) ?"
        } else {
            tagLineLabel.text = item.tagline
        }
        if item.genres.isEmpty {
            genreLabel.text = "Don't know"
        } else {
            genreLabel.text = ListFormatter.localizedString(byJoining: getGenreArray(item))
        }
        popularityLabel.text = "\(item.popularity)"
        adultLabel.text = "\(item.adult)"
        if item.productionCompany.isEmpty {
            companyLabel.text = "Don't know"
        } else {
            companyLabel.text = ListFormatter.localizedString(byJoining: getCompanyArray(item))
        }
        companyLabel.wrapContent()
        if item.productionCountry.isEmpty {
            countryLabel.text = "Don't know"
        } else {
            countryLabel.text = ListFormatter.localizedString(byJoining: getCountryArray(item))
        }
        voteCountLabel.text = "\(item.voteCount)"
        runTimeLabel.text = "\(item.runtime)"
        voteAverage.text = "\(item.voteAverage)"
        releaseDate.text = "\(String(describing: item.releaseDate))"
        releaseDate.wrapContent()
    }
}

extension Reactive where Base: DetailViewController {
    var movieDetail: Binder<MovieDetail> {
        return Binder(self.base) { controller, movieDetail in
            controller.setContent(movieDetail)
        }
    }
}

extension DetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard(name: "DetailScene", bundle: nil)
}
