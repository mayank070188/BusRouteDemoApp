//
//  BusRouteList+CoreDataProperties.swift
//  BusRoute
//
//  Created by Mayank Mathur on 26/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//
//

import Foundation
import CoreData


extension BusRouteList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusRouteList> {
        return NSFetchRequest<BusRouteList>(entityName: "BusRouteList")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var source: String?
    @NSManaged public var destination: String?
    @NSManaged public var tripStartTime: String?
    @NSManaged public var tripDuration: String?
    @NSManaged public var totalSeats: Int64
    @NSManaged public var available: Int64

}
