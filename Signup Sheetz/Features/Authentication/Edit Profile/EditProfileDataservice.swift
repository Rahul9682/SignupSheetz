//
//  EditProfileDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 14/02/25.
//

import Foundation
import Combine

class EditProfileDataService {
    
    @Published var editProfileModel: LoginModel?
    var cancellables: AnyCancellable?
    
    var firstName = ""
    var lastName = ""
    var phone = ""
    init(firstName: String, lastName: String, phone: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
    }
    
    func editProfile(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        let body = [
            "first_name": firstName,
            "last_name": lastName,
            "phone": phone,
        ] as [String : Any]
        print("request body: \(body)")
        cancellables = NetworkingManager.downloadDataWith(endPoint: .editProfile, httpMethod: .post, body: body)
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
                self.editProfileModel = response
                self.cancellables?.cancel()
            })
    }
}
