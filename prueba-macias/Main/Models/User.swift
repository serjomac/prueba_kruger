//
//  User.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import Foundation
struct UserModel {
    let id: String
    let companyId: String
    let permissions: PermissionsContainer?
    var names: String
    var lastNames: String
    var vaccunatedState: Bool
    var email: String
    var username: String
    var password: String
    var bornDate: Date
    var phoneNumber: String
    var ubication: String
    var role: String
}
