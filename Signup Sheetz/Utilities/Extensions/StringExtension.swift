//
//  StringExtension.swift
//  WorkDigital
//
//  Created by Mohammad Kaif on 23/05/22.
//

import Foundation

extension String {
    //_Validation_Error_Messages
    static let emptyFirstName = "Please Enter First Name"
    static let emptyLastName = "Please Enter Last Name"
    static let emptyEmail = "Please Enter Email"
    static let emptyPhoneNumber = "Please Enter Phone Number"
    static let emptyWorktype = "Please Enter Organisation"
    static let inValidEmail = "Please Enter Valid Email"
    static let emptyPassword = "Please Enter Password"
    static let validPassword = "Please Enter Valid Password"
    static let inValidPassword = "Password must be at least 8 characters long and include at least one uppercase letter, one number, and one special character"
    
    //_Methods
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidNumber() -> Bool {
        if self.count == 10 {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword() -> Bool {
        let passwordRegExp = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegExp)
        return passwordPred.evaluate(with: self)
    }
    
    func isValidConfirmPassword(with password: String) -> Bool {
        if password == self {
            return true
        } else {
            return false
        }
    }
}


