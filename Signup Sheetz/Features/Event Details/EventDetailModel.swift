//
//  EventDetailModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import Foundation

class EventDetailModel: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let data: EventData?
}
