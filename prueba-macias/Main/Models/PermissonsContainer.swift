//
//  PermissonContainer.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import Foundation
struct PermissionsContainer {
    struct CompanyPermission {
        let role: CompanyUserRole
        let id: String
    }
    
    let companyPermissions: CompanyPermission

    func role() -> CompanyUserRole? {
        companyPermissions.role
    }
}

protocol HasMyPermissionsContainer {
    var myPermissions: PermissionsContainer? { get }
}

extension HasMyPermissionsContainer {
    func hasPermissions(for permission: Permissions, in companyId: String) -> Bool {
        return myPermissions?.role()?.hasPermission(for: permission) ?? false
    }
}
