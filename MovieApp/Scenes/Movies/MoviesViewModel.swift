//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

final class MoviesViewModel : MoviesViewModelProtocol {
    
    var delegate: MoviesViewModelDelegate?
    private var movieService: MovieServiceProtocol!
    private var router: MoviesRouter!
    private var movies = [Movie]()
    
    init(movieService: MovieServiceProtocol, router: MoviesRouter) {
        self.movieService = movieService
        self.router = router
    }
    
    func loadView() {
        notify(.setLoading(true))
        
        movieService.fetchNowPlayingMovies {[weak self](result) in
            guard let self = self else { return }
            
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
        router.routeToMovieDetail(movieId: movies[index].id)
    }
    
    private func notify(_ output: MoviesViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
