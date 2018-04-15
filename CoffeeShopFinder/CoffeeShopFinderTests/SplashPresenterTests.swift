//
//  SplashPresenterTests.swift
//  CoffeeShopFinderTests
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import XCTest
@testable import CoffeeShopFinder

class SplashPresenterTests: XCTestCase {
    
    var presenter = SplashPresenter()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter.view = self
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //--------------------------------------------
    // requestWhenInUseAuthorization
    var moveExpectation: XCTestExpectation!
    var moveSuccess = false
    func testRequestWhenInUseAuthorization() {
        moveExpectation = expectation(description: "moveExpectation")
        
        presenter.requestWhenInUseAuthorization()
        
        wait(for: [moveExpectation], timeout: 10)
        XCTAssertEqual(moveSuccess, true)
    }
    
}
extension SplashPresenterTests: SplashView {
    func alert(text: String, completion: (() -> Void)?) {
        
    }
    func moveToCoffeeShopList() {
        moveSuccess = true
        moveExpectation.fulfill()
    }
    
}

