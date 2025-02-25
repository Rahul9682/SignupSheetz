//
//  EventDetailDataservice.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import Foundation
import Combine

class EventDetailDataService {
    @Published var eventDetailModel: EventDetailModel?
    var cancellables: AnyCancellable?
    
    var eventID = ""
    init(eventID: String) {
        self.eventID = eventID
    }
    
    func getEventDetail(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        cancellables = NetworkingManager.downloadDataWith(endPoint: .eventDetail(with: self.eventID), httpMethod: .get)
            .decode(type: EventDetailModel.self, decoder: JSONDecoder())
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
                self.eventDetailModel = response
                self.cancellables?.cancel()
            })
    }
}
