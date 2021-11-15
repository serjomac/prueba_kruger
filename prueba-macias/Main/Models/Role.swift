//
//  Role.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import Foundation

protocol Role {
    var permissions: Permissions { get }
    func hasPermission(for permission: Permissions) -> Bool
}

extension Role {
    func hasPermission(for permission: Permissions) -> Bool {
        let permisson = permissions.contains(permission)
        return permisson
    }
}
