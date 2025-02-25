//
//  ChangePasswordDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 14/02/25.
//

import Foundation
import Combine

class ChangePasswordDataService {
    
    @Published var forgotPasswordModel: ForgotPasswordModel?
    var cancellables: AnyCancellable?
    
    var oldPassword = ""
    var newPassword = ""
    init(oldPassword: String, newPassword: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
    }
    
    func changePassword(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        let body = [
            "old_password": oldPassword,
            "new_password": newPassword,
        ] as [String : Any]
        print("request body: \(body)")
        cancellables = NetworkingManager.downloadDataWith(endPoint: .changePassword, httpMethod: .post, body: body)
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
