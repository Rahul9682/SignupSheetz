//
//  HomeViewModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 12/02/25.
//

import Foundation
import Combine

class HomeViewModel {
    
    private var networkingError: NetworkingError?
    private var homeDataService: HomeDataService?
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: INITIALIZER
    init() {
        homeDataService = HomeDataService()
    }
}



//MARK: - API INTEGRATION
extension HomeViewModel {
    func logout(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        homeDataService?.$logutModel
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
        homeDataService?.logout { result in
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
