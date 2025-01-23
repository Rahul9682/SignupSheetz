import Foundation

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

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
