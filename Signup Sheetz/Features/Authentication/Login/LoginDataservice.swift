//
//  LoginDataservice.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import Foundation
import Combine

class LoginDataService {
    
    @Published var loginModel: LoginModel?
    var cancellables: AnyCancellable?
    var loginData = LoginRequestData()
    init(_loginData: LoginRequestData) {
        self.loginData = _loginData
    }
    
    func userLogin(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        let body = [
            "email": loginData.email ?? "",
            "password": loginData.password ?? "",
        ] as [String : Any]
        
        print("request body: \(body)")
        cancellables = NetworkingManager.downloadDataWith(endPoint: .login, httpMethod: .post, body: body)
            .decode(type: LoginModel.self, decoder: JSONDecoder())
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
                self.loginModel = response
                self.cancellables?.cancel()
            })
    }
}
