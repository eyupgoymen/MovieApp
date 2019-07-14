//
//  MovieService.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

protocol MovieServiceProtocol {
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<Movie, Error>) -> ())
}

class MovieService : MovieServiceProtocol {
    
    private let apiProvider = MoyaProvider<MovieAPI>()
    
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        apiProvider.request(.fetchMovies) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: result.data)
                        completion(.success(movieResponse.movies))
                    } catch {
                        let error = try! JSONDecoder().decode(ErrorResponse.self, from: result.data)
                        completion(.failure(MovieError.serviceError(error: error.message)))
                    }
                case .failure(let error):
                    completion(.failure(MovieError.serviceError(error: error.localizedDescription)))
            }
        }
    }
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<Movie, Error>) -> ()) {
        apiProvider.request(.fetchMovieDetail(movieId: movieId)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let movie = try JSONDecoder().decode(Movie.self, from: result.data)
                        completion(.success(movie))
                    } catch {
                        let error = try! JSONDecoder().decode(ErrorResponse.self, from: result.data)
                        completion(.failure(MovieError.serviceError(error: error.message)))
                    }
                case .failure(let error):
                    completion(.failure(MovieError.serviceError(error: error.localizedDescription)))
            }
        }
    }
}
