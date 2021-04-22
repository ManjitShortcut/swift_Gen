//
//  UserListNavigator.swift
//  DNB_TASK
//
//  Created by Manjit on 03/04/2021.
//

import Foundation
import UIKit

class UserListNavigator: Navigator {

    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case favoriteList( favoriteList: [UserInfo])
    }
    weak var navigationContoller: UINavigationController?
    // MARK: - Initializer
    init(navigationController: UINavigationController?) {
        self.navigationContoller = navigationController
    }
    func navigate(to destination: Destination, withComplition completion: () -> Void = {}) {
        switch destination {
        case .favoriteList(let favoriteItem):
            self.navigationContoller?.pushViewController(getfavoriteListViewController(for: favoriteItem), animated: true)
            completion()
        }
    }    
    func pop(to type: Poptype, withComplition completion: () -> Void) {
        
    }
    fileprivate func getfavoriteListViewController(for itemList: [UserInfo]) -> FavoriteViewController {
        
        return FavoriteViewController(viewModel: FavoriteListViewModel(favoriteList: itemList), theme: FavoritListTheme())
    }
}
