//
//  Collection.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct CollectionResponse: Codable, Equatable {
    var name: String
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case name
        case movies = "parts"
    }
}
