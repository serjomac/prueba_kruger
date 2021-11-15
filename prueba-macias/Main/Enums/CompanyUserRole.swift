//
//  CommunityUserRole.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import Foundation

enum CompanyUserRole: String, Codable, CaseIterable {
    case admin
    case employee
}

extension CompanyUserRole: Role {
    var permissions: Permissions {
        switch self {
        case .admin:
             return .all
        case .employee:
            return [.readUser, .updateUser]
        }
        
    }
}
