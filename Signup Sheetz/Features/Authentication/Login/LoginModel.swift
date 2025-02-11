//
//  LoginMo.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let data: UserData?
}

// MARK: - DataClass
struct UserData: Codable {
    let token, firstName, lastName, email: String?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case token
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone
    }
}

//MARK: - Request Model
struct LoginRequestData {
    var email, password: String?
}
