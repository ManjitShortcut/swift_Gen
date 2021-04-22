//
//  FavoriteUserListViewModel.swift
//  DNB_TASK
//
//  Created by Manjit on 04/04/2021.
//

import Foundation

final class FavoriteListViewModel: DataLoadingState {
    
    public var loadingStateCallback: State<[UserList]>?
    fileprivate var favoriteUserList: [UserInfo]
    
    init(favoriteList: [UserInfo]) {
        self.favoriteUserList = favoriteList
    }
    public func onload() {
        
    }
    // MARK: Delete favorite item for index
    public func deleteFavoriteItem(for index: Int, withCompletioinHandler handler: () -> Void) {
        let deleteFavDataDict:[String: UserInfo] = ["deleteFavInfo": favoriteUserList[index]]
        favoriteUserList.remove(at: index)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "deleteFavoriteItem"),object:nil,userInfo: deleteFavDataDict)
        handler()
    }
}
extension FavoriteListViewModel: ListDisplayProtocol {
    var totalCount: Int {
        favoriteUserList.count
    }
    func itemforIndex(_ index: Int) -> UserInfoCellViewModel? {
       return favoriteUserList[index]
    }
    typealias DisplayItem = UserInfoCellViewModel
}
