//
//  Users.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import Foundation

struct Users: Codable {
    let employeeID: Int
    let name: String
    let managerID: Int?
}

extension Users {
    enum CodingKeys: String, CodingKey {
        case employeeID = "employeeId"
        case name
        case managerID = "managerId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        employeeID   = try container.decode(Int.self, forKey: .employeeID)
        name = try container.decode(String.self, forKey: .name)
        managerID = try container.decode(Int?.self, forKey: .managerID)
    }
}
