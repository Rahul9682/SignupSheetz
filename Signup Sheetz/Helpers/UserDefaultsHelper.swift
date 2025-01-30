//
//  UserDefaultsHelper.swift
//  Signup Sheetz
//
//  Created by Braintech on 30/01/25.
//

import Foundation


class LocalStorage {
   
    
    static func saveUserData(data: UserData?) {
        guard let data = data else {return}
        do {
            let encodedData = try JSONEncoder().encode(data)
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(encodedData, forKey: Keys.userData)
            print("Successfully Saved")
        } catch {
            print("Failed to encode [GetItemsData] to Data")
        }
   
    }
    
    
    static func getUserData() -> UserData? {
        if let savedData = UserDefaults.standard.value(forKey: Keys.userData) as? Data {
            var userData: UserData?
            do {
                userData = try JSONDecoder().decode(UserData.self, from: savedData)
                print("Successfully Retrievd")
            } catch {
                print("Failed to Convert to Data")
            }
            return userData
        }
        return nil
    }
    
    
}
