//
//  Movie.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct MovieResponse: Codable{
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable, Equatable {
    var posterPath: String?
    var id: Int
    var title: String
    var voteAverage: Double
    var collection: MovieCollection? // belongs to detail
    var overview: String? // belongs to detail
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id, title
        case voteAverage = "vote_average"
        case collection = "belongs_to_collection"
        case overview
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MovieCollection: Codable {
    var id: Int
    var name: String
}
