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
    let data: LoginData?
}

// MARK: - DataClass
class LoginData: Codable {
    let user: LoginUserData?
    var token: String?
}

// MARK: - User
class LoginUserData: Codable {
    let isActive, organizationType, status: String?
    let imageURL: String?
    let email, firstName: String?
    let id: Int?
    let phone, createdAt, lastName, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case organizationType = "organization_type"
        case status
        case imageURL = "image_url"
        case email
        case firstName = "first_name"
        case id
        case phone
        case createdAt = "created_at"
        case lastName = "last_name"
        case updatedAt = "updated_at"
    }
}

//MARK: - Request Model
struct LoginRequestData {
    var email, password: String?
}
