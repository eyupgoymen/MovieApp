//
//  MovieContract.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

protocol MoviesViewModelProtocol {
    var  delegate : MoviesViewModelDelegate? {get set}
    func loadView()
    func navigateToMovie(at index: Int)
}

enum MoviesViewModelOutput {    
    case setLoading(Bool)
    case showError(Error)
    case moviesFetched([Movie])
}

protocol MoviesViewModelDelegate : class {
    func handleViewModelOutput(_ output: MoviesViewModelOutput)
}

