//
//  BusRouteViewModel.swift
//  BusRoute
//
//  Created by Mayank Mathur on 25/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import Foundation

protocol BusRouteViewModelProtocol {
    func fetchBusRouteDetails(completion: @escaping (Result<[BusRouteListModel], BRError>) -> Void)
}

class BusRouteViewModel: BusRouteViewModelProtocol {
    
    let manager: NetworkManager
    var busRouteListArray: [BusRouteListModel] = []
    
    init(manager: NetworkManager = NetworkManager.shared) {
        self.manager = manager
    }
    
    func fetchBusRouteDetails(completion: @escaping (Result<[BusRouteListModel], BRError>) -> Void) {
        manager.fetchBusRouteData { [weak self] (result: Result<Route, BRError>) in
            let routeList: Result<[BusRouteListModel], BRError>
            switch result {
            case .failure(let error):
                print("Error = \(error)")
                routeList = .failure(error)
                completion(routeList)
            case .success(let route):
                if let routeInfo = route.routeInfo, let routeTiming = route.routeTimings {
                    let listArray = self?.updateBusRouteModel(from: routeInfo, and: routeTiming)
                    
                    // If want to use CoreData, use these methods as required
                    //                    CoreDataManager.shared.deleteAllData()
                    //                    CoreDataManager.shared.saveDataToCoreData(routeListModelArray: listArray ?? [])
                    //                    CoreDataManager.shared.fetchDataFromCoreData()
                    
                    routeList = .success(listArray ?? [])
                    completion(routeList)
                }
            }
        }
    }
    
    func updateBusRouteModel(from busRouteInfo: [RouteInfo], and busRouteTiming:[String: [RouteTiming]]) -> [BusRouteListModel] {
        
        var routesArray:[BusRouteListModel] = []
        for info in busRouteInfo {
            var routeItem = BusRouteListModel()
            routeItem.id = info.id
            routeItem.name = info.name
            routeItem.source = info.source
            routeItem.destination = info.destination
            routeItem.tripDuration = info.tripDuration
            
            if let routeTimingArray = busRouteTiming[routeItem.id ?? ""] {
                for routeTime in routeTimingArray {
                    routeItem.available = routeTime.available
                    routeItem.tripStartTime = routeTime.tripStartTime
                    routeItem.totalSeats = routeTime.totalSeats
                    
                    routesArray.append(routeItem)
                }
            }
        }
        return routesArray
    }
    
    func showOnlyFutureDateBuses(busRouteListModelArray: [BusRouteListModel]?) -> [BusRouteListModel]? {
        // Filter bus routes
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let nowString = formatter.string(from: Date())
        
        let futureBusRoutes = (busRouteListModelArray?.filter { $0.tripStartTime ?? "" > nowString })
        
        // Sorting them now
        let sortedBusArray = futureBusRoutes?.sorted {
            guard let first = $0.tripStartTime else {
                return false
            }
            guard let second = $1.tripStartTime else {
                return true
            }
            return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
        }
        return sortedBusArray
    }
}
