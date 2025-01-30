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
        components.path = "/signupsheetz/api/" + path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)") }
        return url
    }
}

extension EndPoint {
    static var signup: Self {
        EndPoint(path: "signup")
    }
    static var login: Self {
        EndPoint(path: "login")
    }
    

}
