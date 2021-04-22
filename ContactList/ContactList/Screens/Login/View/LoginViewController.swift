//
//  LoginViewController.swift
//  DNB_TASK
//
//  Created by Manjit on 24/03/2021.
//

import UIKit
class LoginViewController: UIViewController,ViewControllerIntilization {
    
    let navigator: LoginNavigator? //should be invoke at the time of creating view controller
    var theme: LoginTheme // should be invoke at the time of creating view controller
    internal  var viewModel: LoginViewModel //should be invoke at the time of creating view controller
    internal lazy var  loginView: LoginView  = LoginView(theme: theme)
    
    init(navigator: LoginNavigator?, viewModel: LoginViewModel, theme: LoginTheme) {
        self.navigator = navigator
        self.viewModel = viewModel
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = theme.backGroundColor
        self.title = "Login"
        self.designUI()
        self.autheticationStatus()
    }
    // MARK: Designui
    // designui
    internal func designUI() {
        self.view.addSubview(loginView)
        loginView .setupUI()
        loginView.equalAndCenter(to: self.view)
        loginView.userInterActionCallback = { [weak self]  status in
            DispatchQueue.main.async {
                switch status {
                case .loginAction:
                    self?.loginActionClick()
                case .passodeAction(let passcode) :
                  self?.viewModel.setLoginInfo(for: .password(password: passcode))
                case .userNameActon(let userId):
                self?.viewModel.setLoginInfo(for: .userName(userName: userId))
                }
            }
        }
    }
    // MARK: Login btn click
    func loginActionClick() {
        viewModel.validateLogin { (validation) in
            switch validation {
            case .userName(let error) :
                self.alert(alertTitle: "Alert", withMessage: error, okAction: { [weak self] in
                    DispatchQueue.main.async {
                    self?.loginView.activeInputAction(for: LoginView.UIInterInputAction.userName)
                    }
                }, buttonText: "Ok")
            case .passCode(let errorMessage) :
                self.alert(alertTitle: "Alert", withMessage: errorMessage, okAction: { [weak self] in
                    DispatchQueue.main.async {
                    self?.loginView.activeInputAction(for: LoginView.UIInterInputAction.passcode)
                    }
                }, buttonText: "Ok")
            }
        }
    }
    // MARK: Navigate to UserList
    // navigate to user to user list page
    open func navigateToUserList(token: String) {
        navigator?.navigate(to: .loginCompleted(token: token))
    }
    // MARK: authetication status callback
   fileprivate func autheticationStatus () {
    viewModel.loadingStateCallback = { [weak self] status in
            self?.hideLoader()
            switch status {
            case .loading:
                self?.showLoader()
            case .loaded(let token):
              self?.navigateToUserList(token: token)
            case .failed(let error):
                self?.showNetworkError(error)
            default:
                break
            }
        }
    }
}
