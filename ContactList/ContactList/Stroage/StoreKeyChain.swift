//
//  StoreKeyChain.swift
//  DNB_TASK
//
//  Created by Manjit on 05/04/2021.
//

import Foundation
import SwiftKeychainWrapper
extension KeychainWrapper.Key {
    static let tokenKey: KeychainWrapper.Key = "Token"
}
struct  KeyChainStroage {

    static func saveToken(token: String) {
        KeychainWrapper.standard.set(token, forKey: KeychainWrapper.Key.tokenKey.rawValue)
    }
    static func getToken() -> String? {
        let token: String? = KeychainWrapper.standard[KeychainWrapper.Key(rawValue: KeychainWrapper.Key.tokenKey.rawValue)]
        return token
    }
    static func deleteToken() {
        KeychainWrapper.standard.remove(forKey: KeychainWrapper.Key(rawValue: KeychainWrapper.Key.tokenKey.rawValue))
    }
}
