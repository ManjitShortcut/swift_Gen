//
//  LoginNavigator.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//

import Foundation
import UIKit

class LoginNavigator: Navigator {
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case loginCompleted(token: String)
    }
    // keep the root navigation controller
    // causing a retain cycle, so better be safe use weak
    weak var navigationContoller: UINavigationController?

    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationContoller = navigationController
    }
    // navigate to destination with call back
    func navigate(to destination: Destination, withComplition completion: () -> Void = {}) {
        switch destination {
        case .loginCompleted:
            self.navigationContoller?.pushViewController(getUserListViewController(), animated: true)
            completion()
        }
    }
    // pop view controller
    func pop(to type: Poptype, withComplition completion: () -> Void) {
        switch type {
        case .root:
            self.navigationContoller?.popToRootViewController(animated: true)
            completion()
        case .previous :
            self.navigationContoller?.popViewController(animated: true)
            completion()
        }
    }
    fileprivate func getUserListViewController() -> UserListViewController {
        if let navigationController = self.navigationContoller {
            let userListNavigator = UserListNavigator(navigationController: navigationController)
            let viewModel = UserListViewModel(endPoint: AppStartup.shouldRunMock() ? UserListEndPointMock():UserListEndPoint())
            return UserListViewController(navigator: userListNavigator, viewModel: viewModel, theme: UserListTheme())
        } else {
            // need to check
            let viewModel = UserListViewModel(endPoint: AppStartup.shouldRunMock() ? UserListEndPointMock():UserListEndPoint())
            let navigationContoller =  UINavigationController()
            let userListNavigator = UserListNavigator(navigationController: navigationContoller)
            return UserListViewController(navigator: userListNavigator, viewModel: viewModel, theme: UserListTheme())
        }
    }
}
