//
//  RegisterDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 23/01/25.
//

import Foundation

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "laravel9.etrueconcept.com"
        components.path = "/" + path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)") }
        return url
    }
}

extension EndPoint {
    static var signup: Self {
        EndPoint(path: "signupsheetz/api/signup")
    }
    
//    static func getRestaurantDetail(with restaurantID: String) -> Self {
//        EndPoint(
//            path: "restaurantDetails&products",
//            queryItems: [
//                URLQueryItem(name: "id", value: restaurantID),
//            ]
//        )
//    }
}
