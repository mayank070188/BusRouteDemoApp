//
//  MockBusRouteViewModel.swift
//  BusRouteTests
//
//  Created by Mayank Mathur on 25/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import XCTest
@testable import BusRoute

class MockBusRouteViewModel: BusRouteViewModelProtocol {
    
    let dummyArray: [BusRouteListModel] = [BusRouteListModel(totalSeats: 11, available: 7, id: "007", name: "James Bond", source: "Home", tripDuration: "2hrs", tripStartTime: "", destination: "Theatre")]
    
    func fetchBusRouteDetails(completion: @escaping (Result<[BusRouteListModel], BRError>) -> Void) {
        completion(.success(dummyArray))
    }
    
}
