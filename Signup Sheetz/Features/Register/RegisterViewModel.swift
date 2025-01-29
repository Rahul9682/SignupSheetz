//
//  RegisterViewModel.swift
//  Signup Sheetz
//
//  Created by Braintech on 29/01/25.
//

import Foundation
import Combine

class RegisterViewModel {
    
    //MARK: PROPERTIES
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var password: String
    @Published var phone: String
    @Published var organizationType: String
    
    @Published var isValidEmail: Bool
    @Published var isValidPassword: Bool
    
    private var networkingError: NetworkingError?
    private var registerDataService: RegisterDataService?
    private var registerValidationError: ValidationError?
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init(signupData: SignupData? = nil) {
        self.firstName = signupData?.firstName ?? ""
        self.lastName = signupData?.lastName ?? ""
        self.email = signupData?.email ?? ""
        self.password = signupData?.password ?? ""
        self.phone = signupData?.phone ?? ""
        self.organizationType = signupData?.organizationType ?? ""
        
        self.isValidEmail = (signupData?.email ?? "").isValidEmail()
        self.isValidPassword = (signupData?.password ?? "").isValidPassword()
        
        if let signupData = signupData {
            registerDataService = RegisterDataService(_signupData: signupData)
        }
    }
}

//MARK: - API INTEGRATION
extension RegisterViewModel {
    func userRegister(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        registerDataService?.$registerModel
            .sink { [weak self] receivedValue in
                guard let self = self else { return }
                if let data = receivedValue {
                    DispatchQueue.main.async { Spinner.stop() }
                    if let success = data.success {
                        if success {
                            // SaveAuthentication.saveUserData(with: data.data)
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
        registerDataService?.userRegister { result in
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
