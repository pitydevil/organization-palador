//
//  Application Endpoint.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import Foundation

//MARK: Application Endpoint Enum State
enum ApplicationEndpoint {
    case getUsers
}

extension ApplicationEndpoint: Endpoint {
    
    //MARK: URLRequest Base URL Host Component
    var host: String {
        "mocki.io/v1"
    }
    
//https://mocki.io/v1/09b08e25-47f8-4395-872f-08235d0f9960
    
    //MARK: URLRequest Path Component
    var path: String {
        switch self {
        case .getUsers:
            return "09b08e25-47f8-4395-872f-08235d0f9960"
        default:
            return ""
        }
    }

    //MARK: URLRequest Method Component
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        default:
            return .get
        }
    }
    
    //MARK: URLRequest Body Component
    var body: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
}
