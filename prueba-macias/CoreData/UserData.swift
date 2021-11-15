//
//  UserData.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 14/11/21.
//

import Foundation
class UserData {
    var userLogin: UserModel?
    private static var privateShared : UserData?
    
    class func sharedInstance() -> UserData {
        guard let uwShared = privateShared else {
            privateShared = UserData()
            return privateShared!
        }
        return uwShared
    }
    class func destroy() {
        self.privateShared = nil
    }
}
