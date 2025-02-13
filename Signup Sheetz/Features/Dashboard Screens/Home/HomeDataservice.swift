//
//  HomeDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 12/02/25.
//

import Foundation
import Combine

class HomeDataService {
    @Published var eventDataModel: EventDataModel?
    @Published var categoryDataModel: CategoryDataModel?
    var cancellables: AnyCancellable?
    
    func getEvents(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        cancellables = NetworkingManager.downloadDataWith(endPoint: .eventListing, httpMethod: .get)
            .decode(type: EventDataModel.self, decoder: JSONDecoder())
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
                self.eventDataModel = response
                self.cancellables?.cancel()
            })
    }
    
    func getCategories(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        cancellables = NetworkingManager.downloadDataWith(endPoint: .categoryListing, httpMethod: .get)
            .decode(type: CategoryDataModel.self, decoder: JSONDecoder())
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
                self.categoryDataModel = response
                self.cancellables?.cancel()
            })
    }
}
