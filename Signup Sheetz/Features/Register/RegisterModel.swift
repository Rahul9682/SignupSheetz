//
//  RegisterModel.swift
//  Signup Sheetz
//
//  Created by Braintech on 29/01/25.
//

import Foundation


import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let email: String
    let password: String
    let workType: String
}

struct APIResponse: Codable {
    let status: Bool
    let message: String
}
