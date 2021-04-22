//
//  AsyncImageViewUnitTest.swift
//  ContactListTests
//
//  Created by Manjit on 06/04/2021.
//

import XCTest

class AsyncImageViewUnitTest: XCTestCase {
    let imageView =  UIImageView()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.\
        imageView.loadRemoteImage(from: URL.init(string: "https://randomuser.me/api/portraits/men/87.jpg"))

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
    //TODO : Will change future
    func testImageForAsncImage() {
        if let url = URL.init(string: "https://randomuser.me/api/portraits/men/87.jpg") {
            let image = CacheImage.shareInstance.getImageForkey(for: url)
            XCTAssertEqual(image?.size, imageView.image?.size, "Mismatch")
        }
    }

}
