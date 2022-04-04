//
//  APIError.swift
//  CryptoTracker
//
//  Created by Fabian Zanotelli Oviedo on 03/04/22.
//

import Foundation

enum APIError: Error{
    case invalidURL
    case invalidSeerverResponse
    case invalidData
}

extension APIError: CustomStringConvertible {
    public var description: String{
        switch self{
        case .invalidURL:
            return "Bad URL"
        case .invalidSeerverResponse:
            return "The server did not return 200"
        case .invalidData:
            return "The server returned bad data"
        }
    }
}
