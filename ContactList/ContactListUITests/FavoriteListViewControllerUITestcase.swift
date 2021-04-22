//
//  FavoriteListViewControllerUITestcase.swift
//  ContactListUITests
//
//  Created by Manjit on 05/04/2021.
//

import XCTest

class FavoriteListViewControllerUITestcase: XCTestCase {
    var vc: FavoriteViewController?
    let viewModel = FavoriteListViewModel(favoriteList: [])
    let theme = FavoritListTheme()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = FavoriteViewController(viewModel: viewModel, theme: theme)
        vc?.viewDidLoad()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCheckTableViewExist() {
        if let tableView = self.vc?.userTableView, let subViews = self.vc?.view.subviews {
            XCTAssertTrue(subViews.contains(tableView),"table view not loadded")
        } else {
            XCTFail("no superview added")
        }
    }
    func testViewLoades() {
        XCTAssertNotNil(self.vc?.view ,"View is not loaaed til now")
    }
    // delegate and data source
    
    func testThatViewConformsToUITableViewDelegate() {
        if let vc = self.vc {
            XCTAssertTrue(vc.conforms(to: UITableViewDelegate.self),"doesnot confirm Delegate not set")
        } else {
            XCTFail("no vc")
        }
    }
    func testThatViewConformsToUITableViewDataSource() {
        if let vc = self.vc {
            XCTAssertTrue(vc.conforms(to: UITableViewDataSource.self),"doesnot confirm data source not set")
        } else {
            XCTFail("no vc")
        }
    }
    func testHasSetDelegateAndDataSource() {
        if let vc = self.vc {
            XCTAssertNotNil(vc.userTableView.delegate, "delegate not set")
        }
        if let vc = self.vc {
            XCTAssertNotNil(vc.userTableView.dataSource, "delegate not set")
        }
    }
    func testNumberOfRow() {
    }
    func testForCell() {
        
    }

}
