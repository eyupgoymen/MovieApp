//
//  CollectionService.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

protocol CollectionServiceProtocol {
    func fetchCollection(collectionId: Int, completion: @escaping (Result<CollectionResponse, Error>) -> ())
}

class CollectionService: CollectionServiceProtocol {
    private let apiProvider = MoyaProvider<MovieAPI>()
    
    func fetchCollection(collectionId: Int, completion: @escaping (Result<CollectionResponse, Error>) -> ()) {
        apiProvider.request(.fetchCollection(collectionId: collectionId)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let collectionResponse = try JSONDecoder().decode(CollectionResponse.self, from: result.data)
                        completion(.success(collectionResponse))
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

