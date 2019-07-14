//
//  MoviesTest.swift
//  MoviesTest
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import MovieApp

class MoviesTest: XCTestCase {

    private var view: MockView!
    private var viewModel: MoviesViewModel!
    private var service: MockMovieService!
    private var router: MoviesRouter!
    
    override func setUp() {
        service = MockMovieService()
        router = MoviesRouter()
        viewModel = MoviesViewModel(movieService: service, router: router)
        view = MockView()
        viewModel.delegate = view
    }
    
    func testFetchingMovies() throws {
        //Fill service - given
        let dummyMovies = [Movie(posterPath: "", id: 1, title: "Movie 1", voteAverage: 1.2, collection: nil, overview: nil),Movie(posterPath: "", id: 2, title: "Movie 2", voteAverage: 1.2, collection: nil, overview: nil)]
        service.movies = dummyMovies
        
        //When
        viewModel.loadView()
        
        //Then
        XCTAssertEqual(view.outputs.count, 3)
        
        guard case .setLoading(true) = try view.outputs.element(at: 0) else {
            XCTFail("Expected .setLoading(true), got \(try view.outputs.element(at: 0))")
            return
        }
        
        guard case .setLoading(false) = try view.outputs.element(at: 1) else {
            XCTFail("Expected .setLoading(false), got \(try view.outputs.element(at: 0))")
            return
        }
        
        guard case .moviesFetched(dummyMovies) = try view.outputs.element(at: 2) else {
            XCTFail("Expected .moviesFetched(dummyMovies), got \(try view.outputs.element(at: 0))")
            return
        }
    }
}

private final class MockView: MoviesViewModelDelegate {
    var outputs: [MoviesViewModelOutput] = []
    
    func handleViewModelOutput(_ output: MoviesViewModelOutput) {
        outputs.append(output)
    }
}

class MockMovieService: MovieServiceProtocol {
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<Movie, Error>) -> ()) {
        
    }
    
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        completion(.success(movies))
    }
    
    var movies: [Movie] = []
}
