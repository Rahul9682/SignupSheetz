//
//  File.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import Foundation
import Combine

class ProfileViewModel {
    
    var arrayOfProfileDetail = [ProfileModel]()
    private var networkingError: NetworkingError?
    private var cancellables = Set<AnyCancellable>()
    private var profileDataService: ProfileDataService?
    
    init() {
        profileDataService = ProfileDataService()
        if let user = LocalStorage.getUserData()?.user {
            arrayOfProfileDetail = [
                ProfileModel(peofileKey: "Name", profileValue: "\(user.firstName ?? "") \(user.lastName ?? "")"),
                ProfileModel(peofileKey: "Email", profileValue: "\(user.email ?? "")"),
                ProfileModel(peofileKey: "Phone", profileValue: "\(user.phone ?? "")"),
                ProfileModel(peofileKey: "Account Type", profileValue: "\(user.organizationType ?? "")"),
                ProfileModel(peofileKey: "Account Created on", profileValue: convertDate(isoDate: user.createdAt ?? "") ?? ""),
            ]
        }
    }
    
    func getNameLetters(firstName: String, lastName: String) -> String {
        let firstLetter = String(firstName.first ?? " ").uppercased()
        let lastLetter = String(lastName.first ?? " ").uppercased()
        return "\(firstLetter)\(lastLetter)"
    }
    
    func convertDate(isoDate: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let date = inputFormatter.date(from: isoDate) {
            // Step 2: Convert Date to Desired Format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMM yyyy" // Example: "12 Feb 2025"
            outputFormatter.timeZone = TimeZone.current // Convert to local timezone if needed

            let formattedDate = outputFormatter.string(from: date)
           return formattedDate
        }
        return nil
    }
}


//MARK: - API INTEGRATION
extension ProfileViewModel {
    func logout(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        profileDataService?.$logutModel
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
        profileDataService?.logout { result in
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
