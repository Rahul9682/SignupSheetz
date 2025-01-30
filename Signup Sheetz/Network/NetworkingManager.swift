//
//  RegisterDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 23/01/25.
//

import Combine
import Foundation
import SwiftyJSON

enum NetworkingError: LocalizedError, Error {
    case wrongStatusCodeMessage(message: String)
    case badURLResponse(url: URL)
    case networkError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .wrongStatusCodeMessage(message: let message):
            return "\(message)"
        case .badURLResponse(url: let url):
            return "[🔥] Bad response from the URL: \(url)"
        case .networkError:
            return "[⚠️] Network error occured."
        case .unknown:
            return "[⚠️] Unknown error occured."
        }
    }
}

class NetworkingManager {
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func downloadDataWith(endPoint: EndPoint, httpMethod: HTTPMethod, body: [String:Any]? = nil, queryString: String = "") -> AnyPublisher<Data, Error> {
        
        print("URL: \(endPoint.url)")
        var request = URLRequest(url: endPoint.url)
        request.httpMethod = httpMethod.value
        //        if let accessToken = Constants.getUser()?.token as? String {
        //            request.allHTTPHeaderFields = ["Content-Type": "application/json",
        //                                           "X-Requested-With": "XMLHttpRequest", "Authorization": "Bearer \(accessToken)"]
        //        } else {
        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       "accept": "*/*"
        ]
        //        }
        
        if let body = body,
           let httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) {
            request.httpBody = httpBody
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: endPoint.url) })
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        print(JSON(output.data))
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>, completionHandler: @escaping ((Result<String, Error>) -> ())) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            completionHandler(.failure(error))
            print(error.localizedDescription)
        }
    }
}

extension NetworkingManager {
    
    enum HTTPMethod: String {
        case get, post, put, delete
        
        var value: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .delete:
                return "DELETE"
            }
        }
    }
}
