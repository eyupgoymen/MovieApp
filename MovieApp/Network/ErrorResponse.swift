//
//  Error.swift
//  MovieApp
//
//  Created by Eyup Kazım Göymen on 13.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct ErrorResponse : Codable {
    var message: String
    var success: Bool?
    var errorCode: Int // might be used to handle specific errors later on
    
    enum CodingKeys: String, CodingKey {
        case message = "status_message"
        case success
        case errorCode = "status_code"
    }
}

// Custom Error
enum MovieError : Error {
    case serviceError(error: String)
    case unknown
}

extension MovieError:  LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .serviceError(let desc):
                return NSLocalizedString(desc, comment: "Error")
            case .unknown:
                return NSLocalizedString("UnexpectedError", comment: "Error")
        }
    }
}
