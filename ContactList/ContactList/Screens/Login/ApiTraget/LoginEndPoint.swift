//
//  LoginEndPoint.swift
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//

import Foundation

enum NetworkLoginEndPoint {
    case login(LoginCredential?)
}
protocol LoginEndProtocol: ApiTargetType,APIRequest {
    mutating func doLogin(for login: LoginCredential)-> Self
}
struct LoginEndPoint: LoginEndProtocol {
    
    var networkEndPoint: NetworkLoginEndPoint = .login(nil)
    mutating func doLogin(for login: LoginCredential)-> Self {
        self.setLoginType(networkEndPoint: .login(login))
        return self
    }
    mutating func setLoginType( networkEndPoint: NetworkLoginEndPoint) {
        self.networkEndPoint = networkEndPoint
    }
}
// MARK: - ApiTargetType
extension LoginEndPoint: ApiTargetType {
    var path: String {
        switch self.networkEndPoint {
        case .login:
            return UrlPath.login.rawValue
        }
    }
    var method: HTTPMethod {
        switch self.networkEndPoint {
        case .login:
            return .post
        }
    }
    var bodyType: HTTPBodyType {
        switch self.networkEndPoint {
        case .login:
            return .json
        }
    }
    var body: Encodable?  {
        switch self.networkEndPoint {
        case .login(let credential):
            return credential
        }
    }
}
// MARK: APIRequest
extension LoginEndPoint:  APIRequest {
    func request<OUTPUT>(responseResult: @escaping ResponseCallback<OUTPUT>) where OUTPUT : Decodable {
        fetch(target: self, complitionHandler: responseResult)
    }
}
