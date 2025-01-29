//
//  RegisterDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 29/01/25.
//

import Foundation
import Combine

class RegisterDataService {
    
    @Published var registerModel: RegisterModel?
    var cancellables: AnyCancellable?
    
    let signupData: SignupData?
    
    init(_signupData: SignupData?) {
        self.signupData = _signupData
    }
    
    func userRegister(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        let body = [
            "email": signupData?.email,
            "phone": signupData?.phone,
            "password": signupData?.password,
            "first_name": signupData?.firstName,
            "last_name": signupData?.lastName,
            "organization_type": signupData?.organizationType,
        ] as [String : Any]
        print("request body: \(body)")
        cancellables = NetworkingManager.downloadDataWith(endPoint: .signup, httpMethod: .post, body: body)
            .decode(type: RegisterModel.self, decoder: JSONDecoder())
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
                self.registerModel = response
                self.cancellables?.cancel()
            })
    }
}
