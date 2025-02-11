//
//  ResetPasswordDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import Foundation
import Combine

class ResetPasswordDataService {
    
    @Published var forgotPasswordModel: ForgotPasswordModel?
    var cancellables: AnyCancellable?
    var email = ""
    var password = ""
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func resetPassword(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        let body = [
            "email": email,
            "password": password,
        ] as [String : Any]
        
        print("request body: \(body)")
        cancellables = NetworkingManager.downloadDataWith(endPoint: .resetPassword, httpMethod: .post, body: body)
            .decode(type: ForgotPasswordModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print("Error ::", error)
                switch error {
                case .finished:
                    break
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }, receiveValue: { response in
                self.forgotPasswordModel = response
                self.cancellables?.cancel()
            })
    }
}
