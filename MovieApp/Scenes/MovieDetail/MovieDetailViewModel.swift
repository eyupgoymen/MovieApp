//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

final class MovieDetailViewModel : MovieDetailViewModelProtocol {
   
    var delegate: MovieDetailViewModelDelegate?
    private var movieService: MovieServiceProtocol!
    private var collectionService: CollectionServiceProtocol!
    private var router: MovieDetailRouter!
    
    init(movieService: MovieServiceProtocol, collectionService: CollectionServiceProtocol, router: MovieDetailRouter) {
        self.movieService = movieService
        self.collectionService = collectionService
        self.router = router
    }
    
    func fetchMovieDetails(movieId: Int) {
        notify(.setLoading(true))
        
        movieService.fetchMovieDetail(movieId: movieId) {[weak self] (result) in
            guard let self = self else { return }
            
            switch result {
                case .success(let movie):
                    self.notify(.movieDetailFetched(movie))
                
                case .failure(let error):
                    self.notify(.showError(error))
            }
        }
    }
    
    func fetchCollection(collectionId: Int) {
        collectionService.fetchCollection(collectionId: collectionId) {[weak self] (result) in
            guard let self = self else { return }
            
            self.notify(.setLoading(false))
            
            switch result {
                case .success(let collection):
                    self.notify(.collectionFetched(collection))
                
                case .failure(let error):
                    self.notify(.showError(error))
            }
        }
    }
    
    func navigateToMovie(movieId: Int) {
        router.routeToMovieDetail(movieId: movieId)
    }
    
    private func notify(_ output: MovieDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

