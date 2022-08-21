//
//  NetworkError.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/21/22.
//

import Foundation

enum NetworkError: Error {
    case noConnection
    case badData
    case otherServerError
    case notAuthorized
    case serviceUnavailable
    case localIssue
    case serverOffline
    case invalidRequest
    case resourceNotFound
    case invalidResponseCode

    var description: String {
        switch self {
        case .noConnection:
            return "No Internet Connection"
        case .otherServerError:
            return "Other Server Error"
        case .badData:
            return "Bad Data"
        case .notAuthorized:
            return "Invalid Account"
        case .serviceUnavailable:
            return "Temporarily Unavailable"
        case .invalidRequest:
            return "Invalid Request"
        case .resourceNotFound:
            return "Resource not found"
        case .invalidResponseCode:
            return "Invalid Response Code"
        default:
            return "Server Error"
        }

    }
}
