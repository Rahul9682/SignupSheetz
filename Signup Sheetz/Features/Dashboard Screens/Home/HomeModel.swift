//
//  HomeModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 12/02/25.
//

import Foundation

// MARK:- EVENT DATA
class EventDataModel: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let data: [EventData]?
}

class EventData: Codable {
    let id: Int?
    let name, slug, startTime, eventDate, address: String?
    let description, image, status: String?
    let categoryID: Int?
    let createdAt, updatedAt: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case startTime = "start_time"
        case eventDate = "event_date"
        case address, description, image, status
        case categoryID = "category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case imageURL = "image_url"
    }
}

// MARK:- CATEGORY DATA
class CategoryDataModel: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let data: [CategoryData]?
}

class CategoryData: Codable {
    let id: Int?
    let name, slug, image, status: String?
    let createdAt, updatedAt: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case imageURL = "image_url"
    }
}
