//
//  AutheticationToken.swift
//  DNB_TASK
//
//  Created by Manjit on 05/04/2021.
//

import Foundation
final class AutheticationToken {
    public var authetiCationToken: String = ""
    static let sharedInstace = AutheticationToken()
    func saveAutheticationToken(token: String) {
        KeyChainStroage.saveToken(token: token)
        self.authetiCationToken = token
    }
    // it is only used when user open the app
    func setAutheticationToken( string: String) {
        self.authetiCationToken = string
    }
}
