//
//  BusRouteTests.swift
//  BusRouteTests
//
//  Created by Mayank Mathur on 24/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import XCTest
@testable import BusRoute

class BusRouteTests: XCTestCase {

    var mockData: MockBusRouteViewModel!
    
    override func setUpWithError() throws {
        mockData = MockBusRouteViewModel()
    }

    override func tearDownWithError() throws {
        mockData = nil
    }

    func testFetchBusRouteDetails() throws {
        mockData.fetchBusRouteDetails { (result) in
            switch result {
            case .success(let routes):
                XCTAssertTrue(routes.count == 1)
                XCTAssertEqual(routes.count, 1)
            case .failure(_):
                XCTFail("Could not load bus routes")
            }
        }
    }
}
