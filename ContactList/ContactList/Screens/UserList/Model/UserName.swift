//
//  UserName.swift
//  DNB_TASK
//
//  Created by Manjit on 01/04/2021.
//

import Foundation
protocol FullName {
    var fullName: String { get  }
}
struct UserName: Hashable, Decodable,Equatable {
    var title: String
    var firstName: String
    var lastName: String
    enum CodingKeys: String, CodingKey {
        case title
        case firstName = "first"
        case lastName = "last"
    }
}

extension UserName: FullName {
    var fullName: String {
      var nameList = [String]()
        if !title.isEmpty {
            nameList.append(title)
        }
        if !firstName.isEmpty {
            nameList.append(firstName)
        }
        if !lastName.isEmpty {
            nameList.append(lastName)
        }
        return nameList.joined(separator: " ")
    }
}
