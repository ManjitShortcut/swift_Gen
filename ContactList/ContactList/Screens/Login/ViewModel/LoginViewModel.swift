//
//  LoginViewModel.swift
//  DNB_TASK
//
//  Created by Manjit on 24/03/2021.
//

import Foundation

enum TextfieldType {
    case userName(userName: String)
    case password(password: String)
}
enum ValidationError {
    case passCode(error: String)
    case userName(error: String)
}

typealias ValidationCompletion = ((ValidationError) -> Void)

final class LoginViewModel: DataLoadingState, ApiEndPoint {

    public lazy var userName: String = ""
    public lazy var passcode: String = ""
    internal var endPoint: LoginEndProtocol

    //call back when user call the web service
    internal var loadingStateCallback: State<String>?
  // DIA
    init(endPoint: LoginEndProtocol) {
        self.endPoint = endPoint
    }
    func setLoginInfo(for field: TextfieldType) {
        switch field {
        case .userName(let userName):
            self.userName = userName
        case .password(let password):
            self.passcode = password
        }
    }
    // validate user when user click login button
   internal func validateLogin( completionHandle: @escaping  ValidationCompletion) {
        if self.userName.isEmpty {
            completionHandle(.userName(error: "Please enter user name"))
        } else if self.passcode.isEmpty {
            completionHandle(.passCode(error: "Please enter password"))
        } else {
            let loginInfo = LoginCredential(userName: userName, passCode: passcode.encriptToString())
            self.doLogin(for: loginInfo)
        }
    }
    // can used from out side function
    public func doLogin(for info: LoginCredential) {
        loadingStateCallback?(LoadingState.loading)
        let responseResult : ResponseCallback<Token> = { [weak self]
            responseResult in
            switch responseResult.result {
            case .success(let data):
                AutheticationToken.sharedInstace.saveAutheticationToken(token: data.token)
                self?.validateTokenLogin(token: data)
            case .failure(let error):
                self?.loadingStateCallback?(LoadingState.failed(error))
            }
        }
        endPoint.doLogin(for: info).request(responseResult: responseResult)
    }
    // check token is availabe or not
    fileprivate func validateTokenLogin( token: Token?) {
        if let tokenInfo =  token,tokenInfo.token.count > 0 {
            self.loadingStateCallback?(LoadingState.loaded(value: tokenInfo.token))
        } else {
            self.loadingStateCallback?(LoadingState.failed(.responseMissing))
        }
    }
}
