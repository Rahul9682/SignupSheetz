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
    case emptyName, invalidPassword, emptyConfirmPassword, invalidConfirmPassword
    
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
        case .emptyName:
            return String.emptyName
        case .invalidPassword:
            return String.inValidPassword
        case .emptyConfirmPassword:
            return String.emptyConfirmPassword
        case .invalidConfirmPassword:
            return String.inValidConfirmPassword
        }
    }
}

enum TextFieldType {
    case loginEmail, loginPassword
    case signupFirstName, signupLastName, signupEmail, signupPhoneNumber, signupPassword, signupWorkType
}
