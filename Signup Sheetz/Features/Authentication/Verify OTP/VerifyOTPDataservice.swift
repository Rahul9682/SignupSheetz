//
//  VerifyOTPDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import Foundation
import Combine

class VerifyOTPDataService {
    
    @Published var forgotPasswordModel: ForgotPasswordModel?
    var cancellables: AnyCancellable?
    var email = ""
    var otp = ""
    
    init(email: String, otp: String) {
        self.email = email
        self.otp = otp
    }
    
    func verifyOTP(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        let body = [
            "otp": otp,
            "email": email,
        ] as [String : Any]
        
        print("request body: \(body)")
        cancellables = NetworkingManager.downloadDataWith(endPoint: .forgotPasswordVerifyOTP, httpMethod: .post, body: body)
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
