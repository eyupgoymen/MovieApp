//
//  MovieDetailContract.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var  delegate : MovieDetailViewModelDelegate? {get set}
    func fetchMovieDetails(movieId: Int)
    func fetchCollection(collectionId: Int)
}

enum MovieDetailViewModelOutput {
    case setLoading(Bool)
    case showError(Error)
    case movieDetailFetched(Movie)
    case collectionFetched(CollectionResponse)
}

protocol MovieDetailViewModelDelegate : class {
    func handleViewModelOutput(_ output: MovieDetailViewModelOutput)
}

protocol DetailCellDelegate : class {
    func navigateToMovieDetail(movieId: Int)
}

@objc enum DetailCellSections: Int {
    case title = 0
    case rate
    case overview
    case similarMovies
    
    init?(section: Int){
        self.init(rawValue: section)
    }
}
