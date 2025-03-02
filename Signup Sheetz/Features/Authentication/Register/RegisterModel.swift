//
//  RegisterModel.swift
//  Signup Sheetz
//
//  Created by Braintech on 29/01/25.
//

import Foundation

class RegisterModel: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let data: RegisterData?
}

class RegisterData: Codable {
    let email, firstName, lastName, organizationType: String?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case organizationType = "organization_type"
        case phone
    }
}


//MARK: - Request Model
struct SignupData {
    var firstName, lastName, organizationType,  email, phone, password, confirmPassword: String?
}
