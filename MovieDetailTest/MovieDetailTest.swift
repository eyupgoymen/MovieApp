//
//  MovieDetailTest.swift
//  MovieDetailTest
//
//  Created by Eyup Kazım Göymen on 14.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieDetailTest: XCTestCase {

    private var view: MockView!
    private var viewModel: MovieDetailViewModel!
    private var movieService: MockMovieService!
    private var collectionService: MockCollectionService!
    private var router: MovieDetailRouter!
    
    override func setUp() {
        movieService = MockMovieService()
        collectionService = MockCollectionService()
        router = MovieDetailRouter()
        viewModel = MovieDetailViewModel(movieService: movieService, collectionService: collectionService, router: router)
        view = MockView()
        viewModel.delegate = view
    }
    
    func testFetchingMovies() throws {
        //Fill service - given
        let dummyMovie_1 = Movie(posterPath: "", id: 1, title: "Movie1", voteAverage: 1.5, collection: nil, overview: "Awesome film")
        let dummyCollection = CollectionResponse(name: "Movies Collection", movies: [dummyMovie_1])
        
        movieService.movie = dummyMovie_1
        collectionService.collection = dummyCollection
        
        //When
        viewModel.fetchMovieDetails(movieId: 1)
        
        //Then
        XCTAssertEqual(view.outputs.count, 2)
        
        guard case .setLoading(true) = try view.outputs.element(at: 0) else {
            XCTFail("Expected .setLoading(true), got \(try view.outputs.element(at: 0))")
            return
        }
        
        guard case .movieDetailFetched(dummyMovie_1) = try view.outputs.element(at: 1) else {
            XCTFail("Expected .movieDetailFetched(movie), got \(try view.outputs.element(at: 0))")
            return
        }
        
        //When
        view.resetOutputs()
        viewModel.fetchCollection(collectionId: 1)
        
        //Then
        XCTAssertEqual(view.outputs.count, 2)
        
        guard case .setLoading(false) = try view.outputs.element(at: 0) else {
            XCTFail("Expected .setLoading(true), got \(try view.outputs.element(at: 0))")
            return
        }
        
        guard case .collectionFetched(dummyCollection) = try view.outputs.element(at: 1) else {
            XCTFail("Expected .collectionFetched(collection), got \(try view.outputs.element(at: 0))")
            return
        }
    }
}

private final class MockView: MovieDetailViewModelDelegate {
    var outputs: [MovieDetailViewModelOutput] = []
    
    func resetOutputs() {
        outputs.removeAll()
    }
    
    func handleViewModelOutput(_ output: MovieDetailViewModelOutput) {
        outputs.append(output)
    }
}

class MockMovieService: MovieServiceProtocol {
    var movie: Movie!
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<Movie, Error>) -> ()) {
        completion(.success(movie))
    }
    
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        
    }
}

class MockCollectionService: CollectionServiceProtocol {
    var collection: CollectionResponse!
    
    func fetchCollection(collectionId: Int, completion: @escaping (Result<CollectionResponse, Error>) -> ()) {
        completion(.success(collection))
    }
}
