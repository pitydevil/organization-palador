//
//  Users.swift
//  Organization
//
//  Created by Mikhael Adiputra on 22/02/23.
//

import Foundation

struct Users: Decodable {
    let employeeID: Int
    let name: String
    let managerID: Int?

    enum CodingKeys: String, CodingKey {
        case employeeID = "employeeId"
        case name
        case managerID = "managerId"
    }
}
