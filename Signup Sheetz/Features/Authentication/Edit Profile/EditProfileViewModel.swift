//
//  EditProfileViewModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 14/02/25.
//

import Foundation
import Combine

class EditProfileViewModel {
    
    //MARK: PROPERTIES
    @Published var firstName: String
    @Published var lastName: String
    @Published var phone: String
    
    private var networkingError: NetworkingError?
    private var dataservice: EditProfileDataService?
    private var registerValidationError: ValidationError?
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init(firstName: String, lastName: String, phone: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        dataservice = EditProfileDataService(firstName: firstName, lastName: lastName, phone: phone)
    }
    
    // MARK: - VALIDATION METHOD
    func validate(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        if firstName.isEmpty {
            completionHandler(.failure(ValidationError.emptyFirstName))
        } else if lastName.isEmpty {
            completionHandler(.failure(ValidationError.emptyLastName))
        } else if phone.isEmpty {
            completionHandler(.failure(ValidationError.emptyPhone))
        } else {
            completionHandler(.success(true))
        }
    }
}

//MARK: - API INTEGRATION
extension EditProfileViewModel {
    func editProfile(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        dataservice?.$editProfileModel
            .sink { [weak self] receivedValue in
                guard let self = self else { return }
                if let data = receivedValue {
                    DispatchQueue.main.async { Spinner.stop() }
                    if let success = data.success {
                        if success {
                            data.data?.token = LocalStorage.getUserData()?.token
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
        dataservice?.editProfile { result in
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
