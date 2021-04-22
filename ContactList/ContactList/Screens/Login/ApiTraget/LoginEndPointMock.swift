//
//  LoginEndPointMock.swift
//  DNB_TASK
//
//  Created by Manjit on 03/04/2021.
//

import Foundation
struct  LoginEndPointMock: LoginEndProtocol {
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
extension LoginEndPointMock: ApiTargetType {
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
    var diskPath: String? {
        switch self.networkEndPoint {
        case .login:
            return MockUrlPath.login.rawValue
        }
    }
}
// MARK: - APIRequest
extension LoginEndPointMock:  APIRequest {
    func request<OUTPUT>(responseResult: @escaping ResponseCallback<OUTPUT>) where OUTPUT : Decodable {
        fetchMock(target: self, complitionHandler: responseResult)
    }
}
