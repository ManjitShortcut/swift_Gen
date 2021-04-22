//
//  MainNavigator.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//

import Foundation
import UIKit
final class RootNavigator {

    internal let navigationController: UINavigationController?
    init(nav: UINavigationController?) {
        self.navigationController = nav
        navigationController?.navigationBar.barTintColor = UIColor().backGroundColor
        UINavigationBar.appearance().backgroundColor = UIColor().backGroundColor
        UINavigationBar.appearance().shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    func start() {
        if let nav  = navigationController {
                let navigator = LoginNavigator(navigationController: nav)
                let loginVc = LoginViewController(navigator: navigator,viewModel: LoginViewModel(endPoint: AppStartup.shouldRunMock() ? LoginEndPointMock() : LoginEndPoint() ), theme: Theme.loginTheme)
                navigationController?.setViewControllers([loginVc], animated: true)
        }
    }
    //MARK: Get Userlist ViewController
    fileprivate func getUserListViewController() -> UserListViewController {
        if let navigationController = self.navigationController {
            let userListNavigator = UserListNavigator(navigationController: navigationController)
            let viewModel = UserListViewModel(endPoint:  AppStartup.shouldRunMock() ? UserListEndPointMock():UserListEndPoint())
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
