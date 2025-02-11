//
//  ForgotPasswordViewModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import Foundation
import Combine

class ForgotPasswordViewModel {
    
    //MARK: PROPERTIES
    @Published var email: String
    @Published var isValidEmail: Bool
    
    private var networkingError: NetworkingError?
    private var forgotPasswordDataService: ForgotPasswordDataService?
    private var validationError: ValidationError?
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init(email: String) {
        self.email = email
        self.isValidEmail = email.isValidEmail()
        forgotPasswordDataService = ForgotPasswordDataService(email: email)
    }
    
    func validation(completionHandler: @escaping ((Result<Bool, Error>) -> ())) {
        if  email.isEmpty {
            self.validationError = .emptyEmail
            completionHandler(.failure(validationError!))
        } else if !isValidEmail {
            self.validationError = .invalidEmail
            completionHandler(.failure(validationError!))
        } else {
            completionHandler(.success(true))
        }
    }
}

//MARK: - API INTEGRATION
extension ForgotPasswordViewModel {
    func forgotPassword(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        forgotPasswordDataService?.$forgotPasswordModel
            .sink { [weak self] receivedValue in
                guard let self = self else { return }
                if let data = receivedValue {
                    DispatchQueue.main.async { Spinner.stop() }
                    if let success = data.success {
                        if success {
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
        forgotPasswordDataService?.forgotPassword { result in
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
