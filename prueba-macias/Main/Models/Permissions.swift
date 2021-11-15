//
//  Permissions.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 13/11/21.
//

import Foundation

struct Permissions: OptionSet {
    let rawValue: Int64
    
    //User rules
    static let readUser = Permissions(rawValue: 1 << 0)
    static let createUser = Permissions(rawValue: 1 << 1)
    static let updateUser = Permissions(rawValue: 1 << 2)
    static let deleteUser = Permissions(rawValue: 1 << 3)
}

extension OptionSet where RawValue == Int64 {
    static var all: Self { .init(rawValue: Int64.max) }
}
