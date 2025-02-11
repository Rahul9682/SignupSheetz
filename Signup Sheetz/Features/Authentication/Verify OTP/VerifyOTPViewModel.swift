//
//  VerifyOTPViewModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 11/02/25.
//

import Foundation
import Combine

class VerifyOTPViewModel {
    
    //MARK: PROPERTIES
    @Published var otp: String
    @Published var email: String
    @Published var isValidEmail: Bool
    
    private var networkingError: NetworkingError?
    private var verifyOTPDataService: VerifyOTPDataService?
    private var validationError: ValidationError?
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init(email: String, otp: String) {
        self.otp = otp
        self.email = email
        self.isValidEmail = email.isValidEmail()
        verifyOTPDataService = VerifyOTPDataService(email: email, otp: otp)
    }
    
    func validation(completionHandler: @escaping ((Result<Bool, Error>) -> ())) {
        if email.isEmpty {
            self.validationError = .emptyEmail
            completionHandler(.failure(validationError!))
        } else if otp.isEmpty || otp.count < 4 {
            self.validationError = .enterOTP
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
extension VerifyOTPViewModel {
    func verifyOTP(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        verifyOTPDataService?.$forgotPasswordModel
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
        verifyOTPDataService?.verifyOTP { result in
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
