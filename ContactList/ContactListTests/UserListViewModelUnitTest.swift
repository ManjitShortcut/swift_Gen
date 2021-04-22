//
//  UserListViewModelUnitTest.swift
//  ContactListTests
//
//  Created by Manjit on 05/04/2021.
//

import XCTest
@testable import ContactList

class UserListViewModelUnitTest: XCTestCase {
    var viewModel: UserListViewModel?
    var waitExpectation: XCTestExpectation?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UserListViewModel(endPoint: UserListEndPointMock())
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
    func testTotalUserList() {
        viewModel?.loadingStateCallback = {status in
                switch status {
                case .loaded(let data):
                    XCTAssertTrue(((data?.count) != nil), "fail data")
                case .failed:
                    XCTFail("Token is not generated")
                default:
                    break
                }
            }
        viewModel?.onload()
    }
    func testFirstUserInfo()throws  {
        let expectation = self.expectation(description: "OutPut data")
        viewModel?.onload()
        var itemViewModel: UserInfoCellViewModel?
        viewModel?.loadingStateCallback = {[weak self] status in
            itemViewModel = self?.viewModel?.itemforIndex(0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(itemViewModel?.disPlayMobileNumber, "20335909" )
        XCTAssertEqual(itemViewModel?.disPlayName, "Mr Nikolai Skavhaug" )
    }
    func testItemIsPresntOrNotForMobileNo() {
        let expectation = self.expectation(description: "OutPut data")
        viewModel?.onload()
        var itemViewModel: UserInfoCellViewModel?
        viewModel?.loadingStateCallback = { [weak self] status in
            itemViewModel = self?.viewModel?.itemforIndex(0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        let item  = self.viewModel?.findOutItem(for: itemViewModel?.disPlayMobileNumber ?? "")
        XCTAssertEqual(item?.phone, itemViewModel?.disPlayMobileNumber)
    }
    func testForFavoriteItem() {
        let expectation = self.expectation(description: "OutPut data")
        viewModel?.onload()
        var itemViewModel: UserInfoCellViewModel?
        viewModel?.loadingStateCallback = { [weak self] status in
            itemViewModel = self?.viewModel?.itemforIndex(0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        let expectatione2 = self.expectation(description: "fav")
        var position:Int? = 0
        self.viewModel?.addAndRemoveItemFromFavoriteList(for: itemViewModel?.disPlayMobileNumber ?? "", withcomplition: { newPosition in
            position = newPosition
            expectatione2.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertEqual(1, viewModel?.getFavItemList().count, "unable find the position")
        XCTAssertEqual(position, 0)
    }

}
