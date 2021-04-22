//
//  UserInfoCellViewModel.swift
//  DNB_TASK
//
//  Created by Manjit on 24/03/2021.
//

import Foundation

public protocol UserInfoCellViewModel {
    var disPlayName: String { get  }
    var disPlayMobileNumber: String { get  }
    var disPlayemailAdress: String { get  }
    var disPlayimageUrl: URL? { get  }
    var displayFavIcon: Bool {get}
}
extension UserInfoCellViewModel {
    var displayFavIcon: Bool {true}
}
extension UserInfo: UserInfoCellViewModel {
    var disPlayemailAdress: String {
        self.email
    }
    var disPlayMobileNumber: String {
        self.phone
    }
    var disPlayimageUrl: URL? {
        self.picture.large
    }
    var disPlayName: String {
        self.name.fullName
    }
}
