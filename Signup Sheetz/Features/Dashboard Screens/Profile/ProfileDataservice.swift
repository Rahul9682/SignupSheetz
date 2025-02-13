//
//  ProfileDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import Foundation
import Combine

class ProfileDataService {
    @Published var logutModel: ForgotPasswordModel?
    var cancellables: AnyCancellable?
    
    func logout(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        cancellables = NetworkingManager.downloadDataWith(endPoint: .logout, httpMethod: .post)
            .decode(type: ForgotPasswordModel.self, decoder: JSONDecoder())
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
                self.logutModel = response
                self.cancellables?.cancel()
            })
    }
}

