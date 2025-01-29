//
//  RegisterViewModel.swift
//  Signup Sheetz
//
//  Created by Braintech on 29/01/25.
//

import Foundation


import Combine
import Foundation

class AuthViewModel {
    @Published var apiResponse: APIResponse?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func registerUser(user: User, completion: @escaping (Result<APIResponse, Error>) -> Void) {
        let endpoint = EndPoint(path: "signupsheetz/api/signup")
        let body: [String: Any] = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "phone_number": user.phoneNumber,
            "email": user.email,
            "password": user.password,
            "work_type": user.workType
        ]
        
        NetworkingManager.downloadDataWith(endPoint: endpoint, httpMethod: .post, body: body)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { response in
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
}
