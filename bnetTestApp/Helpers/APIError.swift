//
//  APIError.swift
//  bnetTestApp
//
//  Created by Dzhek on 01/10/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • APIError

enum APIError: Error {
    case unknown
    case serverUnreacheble
    case decodingFailure
    case invalidData
    case parameterFailure
    
    var customDescription: String {
        switch self {
        case .unknown: return "Unknown error"
        case .serverUnreacheble: return "Server is not available"
        case .decodingFailure: return "Decoding error"
        case .invalidData: return "Invalid Data"
        case .parameterFailure: return "Request parameter error"
        }
    }
    
}

