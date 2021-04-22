//
//  UserListEndPointMock.swift
//  DNB_TASK
//
//  Created by Manjit on 01/04/2021.
//

import Foundation

struct UserListEndPointMock: UserListEndPointProtocol {
    var netWorkEndPoint: NetworkUserListEndPoint = .userlist
    fileprivate mutating func setNetWorkEndPoint (endPoint : NetworkUserListEndPoint){
        self.netWorkEndPoint = endPoint
    }
    mutating func fetchUserList () -> Self {
        self.setNetWorkEndPoint(endPoint: .userlist)
        return self
    }
}
extension UserListEndPointMock: ApiTargetType {
    var headerValues: HTTPHeaders? {
        switch self.netWorkEndPoint {
        case .userlist:
            return [
                "x-auth-token":"Token"
            ]
        }
    }
    var diskPath: String? {
        switch self.netWorkEndPoint {
        case .userlist:
            return MockUrlPath.userList.rawValue
        }
    }
}
extension UserListEndPointMock:  APIRequest {
    func request<OUTPUT>(responseResult: @escaping ResponseCallback<OUTPUT>) where OUTPUT : Decodable {
        fetchMock(target: self, complitionHandler: responseResult)
    }
}
