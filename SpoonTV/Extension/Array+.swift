//
//  Array+.swift
//  SpoonTV
//
//  Created by Nam Ngây on 10/1/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

extension DetailViewController {
    func getGenreArray(_ item: MovieDetail) -> [String] {
        var array: [String] = []
        for i in 0..<item.genres.count {
            let genreName = item.genres[i].genresName
            array.append(genreName)
        }
        return array
    }
    
    func getCompanyArray(_ item: MovieDetail) -> [String] {
        var array: [String] = []
        let companyName = item.productionCompany[0].companyName
        array.append(companyName)
        return array
    }
    
    func getCountryArray(_ item: MovieDetail) -> [String] {
        var array: [String] = []
        for i in 0..<item.productionCountry.count {
            let country = item.productionCountry[i].countryName
            array.append(country)
        }
        return array
    }
}
