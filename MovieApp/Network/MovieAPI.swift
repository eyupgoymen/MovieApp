//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

enum MovieAPI {
    case fetchMovies
    case fetchMovieDetail(movieId: Int)
    case fetchCollection(collectionId: Int)
    
    func getAPIKey() -> String {
        return "3dda81a92ff5546c275f68a3317e3c73"
    }
}

extension MovieAPI : TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
            case .fetchMovies:
                return "movie/now_playing"
            
            case .fetchMovieDetail(let movieId):
                return "movie/\(movieId)"
            
            case .fetchCollection(let collectionId):
                return "collection/\(collectionId)"
        }
    }
    
    var method: Method {
        switch self {
            case .fetchMovies, .fetchMovieDetail(_), .fetchCollection(_):
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .fetchMovies, .fetchMovieDetail(_), .fetchCollection(_):
                return .requestParameters(parameters: ["api_key" : getAPIKey()], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
