//
//  UserDefaultsHelper.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import Foundation

class LocalStorage {
    static func saveUserData(data: LoginData?) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(encodedData, forKey: Keys.userData)
            UserDefaults.standard.synchronize()
        } catch {
            print("Error saving user data: \(error.localizedDescription)")
        }
    }
    
    
    static func getUserData() -> LoginData? {
        if let savedData = UserDefaults.standard.data(forKey: Keys.userData) {
            do {
                return try JSONDecoder().decode(LoginData.self, from: savedData)
            } catch {
                print("Error retrieving user data: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    static func deleteUserData() {
        UserDefaults.standard.removeObject(forKey: Keys.userData)
        UserDefaults.standard.synchronize()
    }
}
