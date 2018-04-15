//
//  CoffeeShopListPresenterTests.swift
//  CoffeeShopFinderTests
//
//  Created by Joey Lee on 15/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import XCTest
@testable import CoffeeShopFinder

class CoffeeShopListPresenterTests: XCTestCase {
    
    var presenter = CoffeeShopListPresenter()
    
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
    // checkLocationAuthorization
    var authoizationExpectation: XCTestExpectation!
    var authoizationResult = false
    func testCheckLocationAuthorzation() {
        authoizationExpectation = expectation(description: "authoizationExpectation")
        
        presenter.checkLocationAuthorization()
        
        wait(for: [authoizationExpectation], timeout: 1)
        XCTAssertEqual(authoizationResult, true)
    }
    //--------------------------------------------
    // reloadData
    var reloadExpectation: XCTestExpectation!
    var reloadResult = false
    func testReloadData() {
        reloadExpectation = expectation(description: "reloadExpectation")
        
        presenter.reloadData()
        
        wait(for: [reloadExpectation], timeout: 20)
        XCTAssertEqual(reloadResult, true)
    }
    
    
}
extension CoffeeShopListPresenterTests: CoffeeShopListView {
    func setCoffeeShopList(_ coffeeShops: [CoffeeShop]) {
        reloadResult = (coffeeShops.count > 0)
        reloadExpectation.fulfill()
    }
    func presentLocationOffViewController() {
        authoizationExpectation.fulfill()
    }
    func dismissLocationOffViewController() {
        authoizationResult = true
        authoizationExpectation.fulfill()
    }
    func showLoadingOnHeaderView() {
        
    }
    func hideLoadingAndStartTimerOnHeaderView(interval: TimeInterval) {
        
    }
    func makeToast(_ text: String?) {
        
    }
}

