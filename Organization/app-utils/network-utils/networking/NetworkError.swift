//
//  NetworkError.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURLRequest
    case emptyResponse
    case badRequest
    case decoding
    case internalServerError
    case underlying(Error)
}
