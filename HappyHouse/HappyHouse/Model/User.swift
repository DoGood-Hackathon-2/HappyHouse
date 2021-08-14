//
//  UserDefault.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/15.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct User {
    @UserDefault(key: "memberId", defaultValue: 1)
    static var memberId: Int
    
    @UserDefault(key: "familyId", defaultValue: 1)
    static var familyId: Int
    
    @UserDefault(key: "familyName", defaultValue: "")
    static var familyName: String
    
}
