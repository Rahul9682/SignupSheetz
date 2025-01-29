import Foundation

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}
https://laravel9.etrueconcept.com/signupsheetz/api/signup

Register request
{
    "mailto:email":"madan8@braintechnosys.com",
    "password":"123abc"
}
After registered response
{"success":true,"status":1,"message":"Email is registered successfully.!","data":{"token":"9|VS1BrySQby5smS1jJWkyNYbFzB0m1VeImdTB2kVpdca9a336","first_name":"Madan","last_name":"Rajput","organization_type":"Business","phone":"9690346666"}}
extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "admin.halalguide.io"
        components.path = "/api/" + path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)") }
        return url
    }
}

extension EndPoint {
    static var login: Self {
        EndPoint(path: "login")
    }
    
    static func getRestaurantDetail(with restaurantID: String) -> Self {
        EndPoint(
            path: "restaurantDetails&products",
            queryItems: [
                URLQueryItem(name: "id", value: restaurantID),
            ]
        )
    }
}
