//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

final class MoviesViewModel : MovieViewModelProtocol {

    //MARK: Delegate
    var delegate: MovieViewModelDelegate?
    var movies = [Movie]()
    var movieService: MovieService!
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func loadView() {
        notify(.setLoading(true))
        movieService.fetchNowPlayingMovies { (result) in
            self.notify(.setLoading(false))
            
            switch result {
                case .success(let movies):
                    self.movies = movies
                    self.notify(.moviesFetched(movies))
                case .failure(let error):
                    self.notify(.showError(error))
            }
        }
    }
    
    func navigateToMovie(at index: Int) {
        
    }
    
    private func notify(_ output: MovieViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

