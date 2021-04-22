//
//  UserListEndPoint.swift
//  DNB_TASK
//
//  Created by Manjit on 01/04/2021.
//

import Foundation

enum NetworkUserListEndPoint {
    case userlist
}
protocol UserListEndPointProtocol: ApiTargetType,APIRequest {
    var netWorkEndPoint: NetworkUserListEndPoint { get set }
    mutating func fetchUserList () -> Self
}
struct UserListEndPoint: UserListEndPointProtocol {
    
    var netWorkEndPoint: NetworkUserListEndPoint = .userlist
    fileprivate mutating func setNetWorkEndPoint (endPoint : NetworkUserListEndPoint){
        self.netWorkEndPoint = endPoint
    }
    mutating func fetchUserList () -> Self {
        self.setNetWorkEndPoint(endPoint: .userlist)
        return self
    }
}
extension UserListEndPoint: ApiTargetType {
    var path: String {
        switch self.netWorkEndPoint {
        case .userlist:
          return  UrlPath.userList.rawValue
        }
    }
    var headerValues: HTTPHeaders? {
        switch self.netWorkEndPoint {
        case .userlist:
            return [
                "x-auth-token": AutheticationToken.sharedInstace.authetiCationToken
            ]
        }
    }
}
extension UserListEndPoint:  APIRequest {
    func request<OUTPUT>(responseResult: @escaping ResponseCallback<OUTPUT>) where OUTPUT : Decodable {
        fetch(target: self, complitionHandler: responseResult)
    }
}
