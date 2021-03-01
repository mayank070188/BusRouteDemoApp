//
//  BusRouteModel.swift
//  BusRoute
//
//  Created by Mayank Mathur on 24/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import Foundation

// MARK: - BusRoute
struct Route: Codable {
    let routeInfo: [RouteInfo]?
    let routeTimings: [String: [RouteTiming]]?
}

// MARK: - RouteInfo
struct RouteInfo: Codable {
    let id, name, source, tripDuration: String?
    let destination, icon: String?
}

// MARK: - RouteTiming
struct RouteTiming: Codable {
    let totalSeats, available: Int?
    let tripStartTime: String?
}

enum CodingKeys: String, CodingKey {
    case available = "avaiable"
}
