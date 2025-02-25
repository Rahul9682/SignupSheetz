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
        //components.host = "laravel9.etrueconcept.com"
        components.host = "bt.etrueconcept.com"
        components.path = "/sheetz/api/" + path
        // components.path = "/signupsheetz/api/" + path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)") }
        return url
    }
}

extension EndPoint {
    // MARK :- AUTHENTICATION
    static var signup: Self {
        EndPoint(path: "auth/signup")
    }
    static var login: Self {
        EndPoint(path: "auth/login")
    }
    static var logout: Self {
        EndPoint(path: "logout")
    }
    static var forgotPasswordSentEmail: Self {
        EndPoint(path: "forgot-password-sentmail")
    }
    static var forgotPasswordVerifyOTP: Self {
        EndPoint(path: "forgot-password-verifyotp")
    }
    static var resetPassword: Self {
        EndPoint(path: "reset-password")
    }
    static var changePassword: Self {
        EndPoint(path: "change-password")
    }
    static var editProfile: Self {
        EndPoint(path: "edit-profile")
    }
    // MARK :- HOME
    static var eventListing: Self {
        EndPoint(path: "event-listing")
    }
    static var categoryListing: Self {
        EndPoint(path: "category-listing")
    }
    static func eventDetail(with eventId: String) -> Self {
        EndPoint(path: "event-detail", queryItems: [URLQueryItem(name: "id", value: eventId)])
    }
}



