//
//  ValidationEnum.swift
//  WorkDigital
//
//  Created by Mohammad Kaif on 24/05/22.
//

import Foundation

enum ValidationError: LocalizedError, Error {
    /*----------------------_Login_----------------------*/
    case emptyEmail, invalidEmail, emptyPassword
    
    /*-----------------------_SignUp_-----------------------*/
    case emptyFirstName,emptyLastName, invalidPassword, emptyPhone, emptyWorkType
    
    var errorDescription: String? {
        switch self {
            /*----_Login_----*/
        case .emptyEmail:
            return String.emptyEmail
        case .invalidEmail:
            return String.inValidEmail
        case .emptyPassword:
            return String.emptyPassword
            /*---_SignUp_---*/
        case .emptyFirstName:
            return String.emptyFirstName
        case .emptyLastName:
            return String.emptyLastName
        case .invalidPassword:
            return String.inValidPassword
        case .emptyPhone:
            return String.emptyPhoneNumber
        case .emptyWorkType:
            return String.emptyWorktype
        }
    }
}

enum TextFieldType {
    case loginEmail, loginPassword
    case signupFirstName, signupLastName, signupEmail, signupPhoneNumber, signupPassword, signupWorkType
}
