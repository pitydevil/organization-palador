//
//  Enums.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import Foundation

//MARK: - NETWORKING ENUMERATION DECLARATION
enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
}

enum genericHandlingError : Int {
    case objectNotFound  = 404
    case methodNotFound  = 405
    case tooManyRequest  = 429
    case success         = 200
    case unexpectedError = 500
}
