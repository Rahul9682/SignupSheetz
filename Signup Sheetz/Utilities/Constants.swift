import Foundation
import SwiftUI

struct Constants {
    // MARK: - KEYS
    static let accessToken = "accessToken"
    static let userData = "userData"
    
    // MARK: - MANAGING SESSION
//    static func removeUser() {
//        UserDefaults.standard.removeObject(forKey: "userData")
//        UserDefaults.standard.removeObject(forKey: "accessToken")
//    }
//    
//    static func saveUser(user: LoginData) {
//        if let encodedData = try? JSONEncoder().encode(user) {
//            UserDefaults.standard.set(encodedData, forKey: "userData")
//        }
//    }
//    
//    static func getUser() -> LoginData? {
//        if let savedData = UserDefaults.standard.data(forKey: "userData") {
//            return try? JSONDecoder().decode(LoginData.self, from: savedData)
//        }
//        return nil
//    }
}
