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
    
    case enterOTP, emptyConfirmPassword, inValidConfirmPassword
    
    case emptyOldPassword, emptyNewPassword
    
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
        case .enterOTP:
            return String.enterOTP
        case .emptyConfirmPassword:
            return String.emptyConfirmPassword
        case .inValidConfirmPassword:
            return String.inValidConfirmPassword
        case .emptyOldPassword:
            return String.emptyOldPassword
        case .emptyNewPassword:
            return String.emptyNewPassword
        }
    }
}

enum TextFieldType {
    case loginEmail, loginPassword
    case forgotEmail
    case signupFirstName, signupLastName, signupEmail, signupPhoneNumber, signupPassword, signupWorkType
    case resetPassword, resetConfirmPassword
    case updateProfileFirstName, updateProfileLastName, updateProfilePhone
    case changeOldPassword, changeNewPassword, changeConfirmPassword
}
