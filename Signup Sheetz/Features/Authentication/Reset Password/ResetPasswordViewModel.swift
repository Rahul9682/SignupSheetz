//
//  ResetPasswordViewModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import Foundation
import Combine

class ResetPasswordViewModel {
    //MARK: PROPERTIES
    @Published var email: String
    @Published var password: String
    @Published var confirmPassword: String
    @Published var isValidEmail: Bool
    @Published var isValidPassword: Bool
    @Published var isValidConfirmPassword: Bool
    
    private var networkingError: NetworkingError?
    private var validationError: ValidationError?
    private var cancellables = Set<AnyCancellable>()
    private var resetPasswordDataService: ResetPasswordDataService?
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init(email: String, password: String, confirmPassword: String) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.isValidEmail = email.isValidEmail()
        self.isValidPassword = password.isValidPassword()
        self.isValidConfirmPassword = confirmPassword.isValidConfirmPassword(with: password)
        resetPasswordDataService = ResetPasswordDataService(email: email, password: password)
    }
    
    func validation(completionHandler: @escaping ((Result<Bool, Error>) -> ())) {
        if email.isEmpty {
            completionHandler(.failure(ValidationError.emptyEmail))
        } else if !isValidEmail {
            completionHandler(.failure(ValidationError.invalidEmail))
        } else if password.isEmpty {
            completionHandler(.failure(ValidationError.emptyPassword))
        } else if !isValidPassword {
            completionHandler(.failure(ValidationError.invalidPassword))
        } else if confirmPassword.isEmpty {
            completionHandler(.failure(ValidationError.emptyConfirmPassword))
        } else if !isValidConfirmPassword {
            completionHandler(.failure(ValidationError.inValidConfirmPassword))
        } else {
            completionHandler(.success(true))
        }
    }
}

//MARK: - API INTEGRATION
extension ResetPasswordViewModel {
    func resetPassword(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        resetPasswordDataService?.$forgotPasswordModel
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
        resetPasswordDataService?.resetPassword { result in
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
