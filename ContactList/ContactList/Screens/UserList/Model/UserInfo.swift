//
//  UserInfo.swift
//  DNB_TASK
//
//  Created by Manjit on 24/03/2021.
//

import Foundation

struct UserInfo: Decodable,Equatable {
    var name: UserName
    var location: Location
    var email: String
    var phone: String
    var dob: Dob
    var picture: Picture

    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        
        return lhs.phone == rhs.phone
    }
}
