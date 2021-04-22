//
//  UserListViewControllerUITest.swift
//  ContactListUITests
//
//  Created by Manjit on 05/04/2021.
//

import XCTest

class UserListViewControllerUITest: XCTestCase {

    var userListViewController: UserListViewController?
    let viewModel = UserListViewModel(endPoint: UserListEndPointMock())
    let theme = UserListTheme()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        let rootNavController =  RootNavigator(nav: UINavigationController())
        let navigator = UserListNavigator(navigationController: rootNavController.navigationController)
        userListViewController = UserListViewController(navigator: navigator, viewModel: viewModel, theme: theme)
        userListViewController?.viewDidLoad()
        continueAfterFailure = false
    
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userListViewController = nil
    }
    func testCheckTableViewExist() {
        if let tableView = self.userListViewController?.userTableView, let subViews = self.userListViewController?.view.subviews {
            XCTAssertTrue(subViews.contains(tableView),"table view not loadded")
        } else {
            XCTFail("no superview added")
        }
    }
    func testViewLoades() {
        XCTAssertNotNil(self.userListViewController?.view ,"View is not loaaed til now")
    }
    // delegate and data source
    
    func testThatViewConformsToUITableViewDelegate() {
        if let vc = self.userListViewController {
            XCTAssertTrue(vc.conforms(to: UITableViewDelegate.self),"doesnot confirm Delegate not set")
        } else {
            XCTFail("no vc")
        }
    }
    func testThatViewConformsToUITableViewDataSource() {
        if let vc = self.userListViewController {
            XCTAssertTrue(vc.conforms(to: UITableViewDataSource.self),"doesnot confirm data source not set")
        } else {
            XCTFail("no vc")
        }
    }
    func testHasSetDelegateAndDataSource() {
        if let vc = self.userListViewController {
            XCTAssertNotNil(vc.userTableView.delegate, "delegate not set")
        }
        if let vc = self.userListViewController {
            XCTAssertNotNil(vc.userTableView.dataSource, "data souce not set")
        }
    }
    func testForCell() {
        
    }
}
