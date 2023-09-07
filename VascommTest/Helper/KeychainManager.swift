//
//  KeychainManager.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import KeychainAccess

final class KeychainManager {
    let keychain: Keychain
    
    static let shared = KeychainManager()
    
    init() {
        let bundle = Bundle.main.bundleIdentifier ?? ""
        keychain = Keychain(service: bundle)
    }
    
    func set(key: String, value: String) throws {
        try keychain.set(value, key: key)
    }
    
    func get(key: String) -> String? {
        do {
            return try keychain.get(key)
        } catch {
            return nil
        }
    }
    
    func remove(key: String) throws {
        try keychain.remove(key)
    }
}

extension KeychainManager {
    func setToken(_ token: String?) throws {
        if let token, !token.isEmpty {
            try set(key: "token", value: token)
        } else {
            try remove(key: "token")
        }
    }
    
    func getToken() -> String? {
        get(key: "token")
    }
}
