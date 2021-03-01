//
//  BusRouteListModel.swift
//  BusRoute
//
//  Created by Mayank Mathur on 25/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import Foundation

// MARK: - BusRouteListModel
struct BusRouteListModel {
    var totalSeats, available: Int?
    var id, name, source, tripDuration, tripStartTime, destination: String?
}
