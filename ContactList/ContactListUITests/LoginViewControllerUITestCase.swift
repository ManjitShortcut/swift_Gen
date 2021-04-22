//
//  LoginViewControllerUiTestCase.swift
//  ContactListUITests
//
//  Created by Manjit on 05/04/2021.
//

import XCTest
@testable import ContactList

class LoginViewControllerUITestCase: XCTestCase {

    var loginViewController: LoginViewController?
   lazy var theme = LoginTheme()
   lazy var viewModel = LoginViewModel(endPoint: LoginEndPointMock())
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        let  rootNavController =  RootNavigator(nav: UINavigationController())
        let loginNavigator = LoginNavigator(navigationController: rootNavController.navigationController!)
        loginViewController = LoginViewController(navigator: loginNavigator, viewModel: viewModel, theme: theme)
        loginViewController?.viewDidLoad()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        self.loginViewController = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testKeyBoardType() throws {
        let textFieldPasscode = try XCTUnwrap(loginViewController?.loginView.passCodeTextField,"textfiled not connect")
        let textFieldUserName = try XCTUnwrap(loginViewController?.loginView.userNameTextField,"textfiled not connect")
        XCTAssertEqual(textFieldPasscode.textContentType, .password, "Missmatch")
        XCTAssertEqual(textFieldUserName.textContentType, .username, "Missmatch")
        XCTAssertEqual(textFieldUserName.returnKeyType, .next, "Missmatch")
        XCTAssertEqual(textFieldPasscode.returnKeyType, .done, "Missmatch")
    }
    func testPasscodeIsSeCureFiled() throws {
        let textFieldPasscode = try XCTUnwrap(loginViewController?.loginView.passCodeTextField,"textfiled not connect")
        XCTAssertTrue(textFieldPasscode.isSecureTextEntry, "Password UITextField is not a Secure Text Entry Fieldg")
   }
    func testTextPlaceHolder() throws {
        let textFieldPasscode = try XCTUnwrap(loginViewController?.loginView.passCodeTextField,"textfiled not connect")
        let textFieldUserName = try XCTUnwrap(loginViewController?.loginView.userNameTextField,"textfiled not connect")
        XCTAssertEqual(textFieldUserName.placeholder, "Enter username", "Missmatch")
        XCTAssertEqual(textFieldPasscode.placeholder, "Enter passcode", "Missmatch")
    }
    func testbackGroundColor () throws {
        let view = try XCTUnwrap(loginViewController?.view,"textfiled not connecteds")
        XCTAssertEqual(view.backgroundColor,theme.backGroundColor, "Mismatch")
    }
    func testLoginBtnTap() throws {
        let loginButton = try XCTUnwrap(loginViewController?.loginView.loginButton,"button not connect")
        loginButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(loginButton.titleLabel?.text,"Login","Missmatch")
    }
    func testCheckLoginViewExist() {
        if let loginView = self.loginViewController?.loginView, let subViews = self.loginViewController?.view.subviews {
            XCTAssertTrue(subViews.contains(loginView),"loginview view not loadded")
        } else {
            XCTFail("no superview added")
        }
    }
    func testShowingLoader() {
        let passcodeValue = "abc@123"
        let userName = "abc"
        let app = XCUIApplication()
        let enterUserNameTextField = app.textFields["Enter username"]
        let passCodeTextFiled = app.secureTextFields["Enter passcode"]
        enterUserNameTextField.tap()
        enterUserNameTextField.typeText(userName)
        passCodeTextFiled.tap()
        passCodeTextFiled.typeText(passcodeValue)
        app.buttons["Login"].staticTexts["Login"].tap()
        let inProgressActivityIndicator = app.activityIndicators["In progress"]
        XCTAssert(inProgressActivityIndicator.exists)
    }
    func testEnterPasscodeAlertmessage() {
        let app = XCUIApplication()
        let enterUserNameTextField = app.textFields["Enter username"]
        enterUserNameTextField.tap()
        enterUserNameTextField.typeText("test")
        app.buttons["Login"].staticTexts["Login"].tap()
        let alertError = app.alerts["Alert"].scrollViews.otherElements.buttons["Ok"]
        XCTAssert(alertError.exists)
        alertError.tap()
    }
    func testEmptyUserAlertmessage() {
        let app = XCUIApplication()
        app.textFields["Enter username"].tap()
        app.buttons["Login"].tap()
        let alertError = app.alerts["Alert"].scrollViews.otherElements.buttons["Ok"]
        XCTAssert(alertError.exists)
        alertError.tap()
    }
    func testLoginSuccesFul () {
        let passcodeValue = "abc@123"
        let userName = "abc"
        let app = XCUIApplication()
        let enterUserNameTextField = app.textFields["Enter username"]
        XCTAssert(enterUserNameTextField.exists)
        let passCodeTextFiled = app.secureTextFields["Enter passcode"]
        XCTAssert(passCodeTextFiled.exists)
        enterUserNameTextField.tap()
        enterUserNameTextField.typeText(userName)
        passCodeTextFiled.tap()
        passCodeTextFiled.typeText(passcodeValue)
        app.buttons["Login"].staticTexts["Login"].tap()
    }
    func testViewLoades() {
        
//        let app = XCUIApplication()
//        app.textFields["Enter username"].tap()
//        
//        let enterPasscodeSecureTextField = app.secureTextFields["Enter passcode"]
//        enterPasscodeSecureTextField.tap()
//        enterPasscodeSecureTextField.tap()
//        app.buttons["Login"].tap()
//        
//        let tablesQuery2 = app.tables
//        let tablesQuery = tablesQuery2
//        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Mr Nikolai Skavhaug"]/*[[".cells.staticTexts[\"Mr Nikolai Skavhaug\"]",".staticTexts[\"Mr Nikolai Skavhaug\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
//        tablesQuery2/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mr Nikolai Skavhaug")/*[[".cells.containing(.staticText, identifier:\"20335909\")",".cells.containing(.staticText, identifier:\"Mr Nikolai Skavhaug\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["suit.heart"].tap()
//        tablesQuery2/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mr Lucas Gill")/*[[".cells.containing(.staticText, identifier:\"505-931-7584\")",".cells.containing(.staticText, identifier:\"Mr Lucas Gill\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["suit.heart"].tap()
//        app.navigationBars["User List"].buttons["favourite"].tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["20335909"]/*[[".cells.staticTexts[\"20335909\"]",".staticTexts[\"20335909\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
//        tablesQuery2/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"20335909")/*[[".cells.containing(.button, identifier:\"Delete\")",".cells.containing(.staticText, identifier:\"Mr Nikolai Skavhaug\")",".cells.containing(.staticText, identifier:\"20335909\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["505-931-7584"]/*[[".cells.staticTexts[\"505-931-7584\"]",".staticTexts[\"505-931-7584\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
//        tablesQuery2.cells.children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mr Lucas Gill"]/*[[".cells.staticTexts[\"Mr Lucas Gill\"]",".staticTexts[\"Mr Lucas Gill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                       
    }

    //TODO FUTURE
//    func testLoginsubView() {
//        if let loginView = self.loginViewController?.loginView {
////            XCTAssertTrue(loginView.subviews.contains(loginView.userNameTextField)," username view not loadded")
//            XCTAssertTrue(loginView.subviews.contains(loginView.passCodeTextField)," passCodeTextField view not loadded")
//            XCTAssertTrue(loginView.subviews.contains(loginView.loginButton)," loginButton view not loadded")
//        } else {
//            XCTFail("no superview added")
//        }
//
//    }

}
