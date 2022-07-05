//
//  UserDefaultWrapper.swift
//
//
//  Created by arkhyp on 09.01.2022.
//  Copyright © 2022. All rights reserved.
//

import Foundation

@propertyWrapper
public class UserDefault<T> {
    let key: String
    let defaultValue: T
    var userDefaults: UserDefaults
    var cachedValue: T?

    public init(_ key: String, userDefaults: UserDefaults = .standard, defaultValue: T) {
        self.key = key
        self.userDefaults = userDefaults
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            if let cachedValue = cachedValue {
                return cachedValue
            } else {
                let cachedValue = userDefaults.object(
                    forKey: key) as? T ?? defaultValue
                self.cachedValue = cachedValue
                return cachedValue
            }
        }
        set {
            if let value = newValue as? OptionalProtocol,
                value.isNil {
                userDefaults.removeObject(forKey: key)
            } else {
                userDefaults.set(newValue, forKey: key)
            }
            userDefaults.synchronize()
            cachedValue = newValue
        }
    }
}

private protocol OptionalProtocol {
    var isNil: Bool { get }
}

extension Optional: OptionalProtocol {
    // swiftlint:disable strict_fileprivate
    fileprivate var isNil: Bool {
        return self == nil
    }
}
