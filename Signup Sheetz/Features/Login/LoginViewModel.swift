//
//  LoginViewModel.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import Foundation
import Combine

class LoginViewModel {
    
    //MARK: PROPERTIES
   
    @Published var email: String
    @Published var password: String
    @Published var isValidEmail: Bool
    
    private var networkingError: NetworkingError?
    private var loginDataService: LoginDataService?
    private var validationError: ValidationError?
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init(loginData: LoginRequestData? = nil) {
        self.email = loginData?.email ?? ""
        self.password = loginData?.password ?? ""
        self.isValidEmail = (loginData?.email ?? "").isValidEmail()
        if let loginData = loginData {
           loginDataService = LoginDataService(_loginData: loginData)
        }
    }
    
    func validation(completionHandler: @escaping ((Result<Bool, Error>) -> ())) {
        if  email.isEmpty {
            self.validationError = .emptyEmail
            completionHandler(.failure(validationError!))
        } else if !isValidEmail {
            self.validationError = .invalidEmail
            completionHandler(.failure(validationError!))
        } else if password.isEmpty {
            self.validationError = .emptyPassword
            completionHandler(.failure(validationError!))
        } else {
            completionHandler(.success(true))
        }
    }
}


//MARK: - API INTEGRATION
extension LoginViewModel {
    func userLogin(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        loginDataService?.$loginModel
            .sink { [weak self] receivedValue in
                guard let self = self else { return }
                if let data = receivedValue {
                    DispatchQueue.main.async { Spinner.stop() }
                    if let success = data.success {
                        if success {
                            // SaveAuthentication.saveUserData(with: data.data)
                            LocalStorage.saveUserData(data: data.data)
                            completionHandler(.success(data.message ?? "N/A"))
                        } else {
                            self.networkingError = .wrongStatusCodeMessage(message: data.message ?? "")
                            if let networkingError = self.networkingError {
                                completionHandler(.failure(networkingError))
                            }
                        }
                    }
                } else {
                    if let networkingError = self.networkingError {
                        DispatchQueue.main.async { Spinner.stop() }
                        completionHandler(.failure(networkingError))
                    }
                }
            }.store(in: &cancellables)
        loginDataService?.userLogin { result in
            DispatchQueue.main.async { Spinner.stop() }
            switch result {
            case .success(let message):
                print(message)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
