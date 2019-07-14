//
//  ServiceTest.swift
//  ServiceTest
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import MovieApp

class ServiceTest: XCTestCase {
    
    func testParsingMovie() throws {
        let data = try getDataFromBundle(fileName: "NowPlayingMovies", ext: "json")
        
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        XCTAssertEqual(movieResponse.movies.count, 2)
        XCTAssertEqual(movieResponse.movies.first?.id, 297761)
        XCTAssertEqual(movieResponse.movies[1].id, 324668)
    }
    
    func testParseMovieDetail() throws {
        let data = try getDataFromBundle(fileName: "MovieDetail", ext: "json")
        
        let movieDetailResponse = try JSONDecoder().decode(Movie.self, from: data)
        
        XCTAssertEqual(movieDetailResponse.id, 12)
        XCTAssertEqual(movieDetailResponse.title, "Finding Nemo")
    }
    
    func testParseCollection() throws {
        let data = try getDataFromBundle(fileName: "Collection", ext: "json")
        
        let collectionResponse = try JSONDecoder().decode(CollectionResponse.self, from: data)
        
        XCTAssertEqual(collectionResponse.name, "Star Wars Collection")
        XCTAssertEqual(collectionResponse.movies.count, 9)
    }
    
    func getDataFromBundle(fileName: String, ext: String) throws -> Data {
        let bundle = Bundle(for: ServiceTest.self)
        let url = try bundle.url(forResource: fileName, withExtension: ext).unwrap()
        return try Data(contentsOf: url)
    }
}

