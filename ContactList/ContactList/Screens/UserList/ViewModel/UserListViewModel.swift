//
//  UserListViewModel.swift
//  DNB_TASK
//
//  Created by Manjit on 24/03/2021.
//

import Foundation
protocol ListDisplayProtocol {
    associatedtype DisplayItem
    var totalCount: Int {get}
    func itemforIndex(_ index: Int)-> DisplayItem?
}
final class UserListViewModel: DataLoadingState,ApiEndPoint  {
    internal var userList: [UserInfo]?
    public var loadingStateCallback: State<[UserInfo]?>?
    internal var endPoint: UserListEndPointProtocol
    // used when user click fav icon
    fileprivate lazy var favoriteUserList =  [UserInfo]()
    init(endPoint: UserListEndPointProtocol) {
        self.endPoint = endPoint
    }
    // MARK: Onload
    public func onload() {
        self.fetchAllUserList()
    }
    // MARK: Fetching all userlist
    fileprivate func fetchAllUserList() {
        loadingStateCallback?(LoadingState.loading)
        let responseResult : ResponseCallback<UserList> = { [weak self]
            responseResult in
            switch responseResult.result {
            case .success(let data):
                self?.setUserList(data)
            case .failure(let error):
                self?.loadingStateCallback?(LoadingState.failed(error))
            }
        }
        self.endPoint.fetchUserList().request(responseResult: responseResult)
    }
    // MARK: Setting response data to local user list
    fileprivate func setUserList(_ userListInfo: UserList?) {
        if let info = userListInfo {
            self.userList = info.data
            self.loadingStateCallback?(LoadingState.loaded(value: info.data ?? nil))
        }
    }
    // MARK: Adding item to favorite list
    public func addAndRemoveItemFromFavoriteList(for identifier: String, withcomplition complition:(Int?)->Void) {
        if let item = findOutItem(for: identifier), let list = userList {
            if !favoriteUserList.isItemPresent(for: item) {
                favoriteUserList.append(item)
            } else {
                if let position =  favoriteUserList.position(for: item) {
                    favoriteUserList.remove(at: position)
                }
            }
            complition(list.position(for: item))
        } else {
            complition(nil)
        }
    }
    internal func findOutItem(for identifier: String) -> UserInfo? {
        if let list  = userList {
            if let userInfo = list.first(where:{$0.phone == identifier}) {
                return userInfo
            }
            return nil
        }
        return nil
    }
    public func removeFavoriteItem(item: UserInfo) {
        if let position =  favoriteUserList.position(for: item) {
            favoriteUserList.remove(at: position)
        }
    }
    func getFavItemList() -> [UserInfo] {
        return favoriteUserList
    }
}
extension UserListViewModel: ListDisplayProtocol {
    var totalCount: Int {
       userList?.count ?? 0
    }
    func itemforIndex(_ index: Int) -> UserInfoCellViewModel? {
        if let item = userList?[index] {
            return item
        }
        return nil
    }
    func favIconStatus(for index:  Int) -> Bool {
        if let item = userList?[index] {
          return favoriteUserList.contains(item)
        } else {
            return false
        }
    }
    typealias DisplayItem = UserInfoCellViewModel
}
