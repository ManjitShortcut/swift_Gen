//
//  LoginViewModelTest.swift
//  ContactListTests
//
//  Created by Manjit on 05/04/2021.
//

import XCTest
@testable import ContactList

class LoginViewModelTest: XCTestCase {

    var loginViewModel: LoginViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginViewModel = LoginViewModel(endPoint: LoginEndPointMock())
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testUserNamePasswordEntry() {
        loginViewModel?.setLoginInfo(for: TextfieldType.password(password: "Password"))
        loginViewModel?.setLoginInfo(for: TextfieldType.userName(userName: "Username"))
        XCTAssertEqual("Password", loginViewModel?.passcode,"passcode is mismatch")
        XCTAssertEqual("Username", loginViewModel?.userName,"userid is mismatch")

    }
    func testCheckValidationErrorMessage() {
        loginViewModel?.setLoginInfo(for: TextfieldType.password(password: ""))
        loginViewModel?.setLoginInfo(for: TextfieldType.userName(userName: "test"))
        loginViewModel?.validateLogin(completionHandle: { errorStatus in
            switch errorStatus {
            case .passCode(let error) :
                XCTAssertEqual("Please enter password",error,"Mismatch error message")
            default:
                XCTFail("Mismatch type")
            }
        })
        loginViewModel?.setLoginInfo(for: TextfieldType.userName(userName: ""))
        loginViewModel?.setLoginInfo(for: TextfieldType.password(password: "asdfsf"))
        loginViewModel?.validateLogin(completionHandle: { errorStatus in
            switch errorStatus {
            case .userName(let error) :
                XCTAssertEqual("Please enter user name",error,"Mismatch error message")
            default:
                XCTFail("Mismatch type")
            }
        })
    }
    func testCheckLoginToken() {
        
        let expectation = self.expectation(description: "token output")
        var newToken: String = ""
        loginViewModel?.setLoginInfo(for: TextfieldType.password(password: "Password"))
        loginViewModel?.setLoginInfo(for: TextfieldType.userName(userName: "Username"))
        loginViewModel?.validateLogin(completionHandle: { _ in

        })
        loginViewModel?.loadingStateCallback = {  status in
                switch status {
                case .loaded(let token):
                    newToken = token
                default:
                    break
                }
            expectation.fulfill()
            }
         waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(newToken,"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c","Mismatch error message")

    }
}
