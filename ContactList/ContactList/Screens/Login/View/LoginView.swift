//
//  LoginView.swift
//  DNB_TASK
//
//  Created by Manjit on 04/04/2021.
//

import UIKit
typealias UserInterActionCallback = ((LoginView.UIInterOutPutAction) -> Void)

class LoginView: UIView,ViewProtocol {
    
    enum UIInterOutPutAction {
        case userNameActon(userName: String)
        case passodeAction(passcode: String)
        case loginAction
    }
    enum UIInterInputAction {
        case userName
        case passcode
    }
    // call back when user change text
    
    open var userInterActionCallback: UserInterActionCallback?
    internal lazy var userNameTextField = TextFiled().configure(placeHolder: "Enter username").returnKey(.next).contentType(.username)
    internal lazy var passCodeTextField = TextFiled().configure(placeHolder: "Enter passcode", isSeure: true).returnKey(.done).contentType(.password)
    internal lazy var loginButton = Button().configure(title: "Login",backGroundImage: UIImage.init(named: "loginBtnBg"))

    let theme: LoginTheme

    init(theme: LoginTheme) {
        self.theme = theme
        super.init(frame: CGRect.zero)
    }
    func setupUI() {
        //userName
        let userNameStackView = desingGroupView(imageName: "person.fill", textFiled: userNameTextField)
        //password entry stack view
        let passcodeStackView = desingGroupView(imageName: "lock.fill", textFiled: passCodeTextField)
        
        let imageSeparator = UIImageView()
        imageSeparator.backgroundColor = UIColor().separatorColor
        let userEntryStackView = CustomStackView().configure(spacing: 0)
        userEntryStackView.addingSubviews(subViews: [userNameStackView,imageSeparator,passcodeStackView])
        userEntryStackView.backgroundColor = UIColor.white
        userEntryStackView.layer.borderColor = UIColor.white.cgColor
        userEntryStackView.layer.cornerRadius = 5
       
        imageSeparator.setHeight(to: 1)
        // login button stack view
        let stackButtonView = CustomStackView().configure(alignment: .fill)
        //login button
        let loginButton = Button().configure(title: "Login",backGroundImage: UIImage.init(named: "loginBtnBg"))
        loginButton.cornerRadius = 10
        loginButton.action(handler: {  [weak self] in
            self?.userInterActionCallback?(.loginAction)
        })
        //loginButton constraint
        loginButton.setHeight(to: 50)
        stackButtonView.addingSubviews(subViews: [loginButton])
        //stack view for login page
        let stackViewLogin = CustomStackView().configure(spacing: theme.spacing.verticalSpacingGroup)
        self.addSubview(stackViewLogin)
        // adding subitem to login stackview
        stackViewLogin.addingSubviews(subViews: [userEntryStackView, stackButtonView])
        // activate constraint
        stackViewLogin.center(to: self,verticalConst: -50)
        let spacingMargin = theme.spacing.loginViewMargin
        stackViewLogin.setMargin(to: self,leftMargin: spacingMargin,rightMargin: -spacingMargin)
    
        stackViewLogin.backgroundColor = UIColor.clear
        stackViewLogin.layer.cornerRadius = 5
        stackViewLogin.clipsToBounds = true
        userNameTextField.delegate = self
        passCodeTextField.delegate = self
        
        passCodeTextField.action { [weak self] (newText)  in
            self?.userInterActionCallback?(.userNameActon(userName: newText))
        }
        userNameTextField.action { [weak self] (newText)  in
            self?.userInterActionCallback?(.passodeAction(passcode: newText))
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // this metod is only responsible for create a iocn with text fileds
    fileprivate func desingGroupView(imageName: String, textFiled: TextFiled) -> CustomStackView {
        let useStackView = CustomStackView().configure(type: .horizontal,spacing:0, alignment: .center,distribution: .fill)
        let imageViewBg = UIImageView.init()
        let imageIonc = UIImageView.init(image: UIImage.init(systemName:imageName))
        imageIonc.tintColor = UIColor.black
        imageViewBg .addSubview(imageIonc)
        useStackView.addingSubviews(subViews:[imageViewBg,textFiled])

        //imageIonc .constraints
        imageIonc.translatesAutoresizingMaskIntoConstraints = false
        imageIonc.center(to: imageViewBg,verticalConst: 0)
        imageIonc.setWidth(to: 24)
        imageIonc.setHeight(to: 24)
        // imageViewBg. constraints
        imageViewBg.setWidth(to: 40)
        imageViewBg.setHeight(to: useStackView)
         //textFiled.constraint
        textFiled.setHeight(to: 50)
        return useStackView
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    open func activeInputAction(for inputAction: UIInterInputAction) {
        switch inputAction {
        case .passcode:
              passCodeTextField .becomeFirstResponder()
        case .userName:
              userNameTextField .becomeFirstResponder()
        }
    }
}
extension LoginView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passCodeTextField.becomeFirstResponder()
        } else if textField == passCodeTextField {
            passCodeTextField.resignFirstResponder()
        }
        return false
    }
}
