//
//  EventDetailViewModel.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import Foundation
import Combine

class EventDetailViewModel {
    
    //MARK: PROPERTIES
    @Published var eventID: String
    private var networkingError: NetworkingError?
    private var cancellables = Set<AnyCancellable>()
    private var eventDetailDataService: EventDetailDataService?
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    var eventData: EventData?
    
    //MARK: INITIALIZER
    init(eventID: String) {
        self.eventID = eventID
        eventDetailDataService = EventDetailDataService(eventID: eventID)
    }
    
    func formatEventDate(dateString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {
            // Step 2: Extract Day
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "d"
            let day = dayFormatter.string(from: date)
            
            // Step 3: Extract Month and Year
            let monthYearFormatter = DateFormatter()
            monthYearFormatter.dateFormat = "MMMM yyyy" // "February 2025"
            let monthYear = monthYearFormatter.string(from: date)
            return "\(day), \(monthYear)"
        }
        return nil
    }
    
    func formatEventTime(dateString: String?, timeString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {
            // Step 2: Extract Day
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            let day = dayFormatter.string(from: date)
            return "\(day), \(timeString ?? "")"
        }
        return nil
    }
}

//MARK: - API INTEGRATION
extension EventDetailViewModel {
    func getEventDetail(completionHandler: @escaping ((Result<String, Error>) -> ())) {
        DispatchQueue.main.async { Spinner.start() }
        eventDetailDataService?.$eventDetailModel
            .sink { [weak self] receivedValue in
                guard let self = self else { return }
                if let data = receivedValue {
                    DispatchQueue.main.async { Spinner.stop() }
                    if let success = data.success {
                        if success {
                            self.eventData = data.data
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
        eventDetailDataService?.getEventDetail { result in
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
