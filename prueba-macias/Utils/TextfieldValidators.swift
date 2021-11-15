//
//  TextfieldValidators.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 14/11/21.
//

import Foundation
class TextfieldValidators {
    // MARK: - VALIDARTORS
    class func isEmpty(value: String?) -> Bool {
        guard let _ = value else {
            return false
        }
        if value == "" {
            return true
        } else {
            return false
        }
    }
    
    class func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    class func isIdValid(id: String) -> Bool {
        if id.count == 10 {
            return true
        } else {
            return false
        }
    }
}
