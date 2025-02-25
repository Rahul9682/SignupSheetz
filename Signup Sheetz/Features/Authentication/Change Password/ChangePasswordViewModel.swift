//
//  ChangePasswordViewModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 14/02/25.
//

import Foundation
import Combine

class ChangePasswordViewModel {
    
    //MARK: PROPERTIES
    @Published var oldPassword: String
    @Published var newPassword: String
    @Published var confirmPassword: String
    @Published var isValidOldPassword: Bool
    @Published var isValidNewPassword: Bool
    @Published var isValidConfirmPassword: Bool
    
    private var networkingError: NetworkingError?
    private var dataservice: ChangePasswordDataService?
    private var registerValidationError: ValidationError?
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init(oldPassword: String, newPassword: String, confirmPassword: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
        self.isValidOldPassword = oldPassword.isValidPassword()
        self.isValidNewPassword = newPassword.isValidPassword()
        self.isValidConfirmPassword = confirmPassword.isValidConfirmPassword(with: newPassword)
        
        dataservice = ChangePasswordDataService(oldPassword: oldPassword, newPassword: newPassword)
    }
    
    // MARK: - VALIDATION METHOD
    func validate(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        if oldPassword.isEmpty {
            completionHandler(.failure(ValidationError.emptyOldPassword))
        } else if !isValidOldPassword {
            completionHandler(.failure(ValidationError.invalidPassword))
        } else if newPassword.isEmpty {
            completionHandler(.failure(ValidationError.emptyNewPassword))
        } else if !isValidNewPassword {
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
extension ChangePasswordViewModel {
    func changePassword(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        dataservice?.$forgotPasswordModel
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
        dataservice?.changePassword { result in
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
