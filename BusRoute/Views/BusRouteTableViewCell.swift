//
//  BusRouteTableViewCell.swift
//  BusRoute
//
//  Created by Mayank Mathur on 28/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import UIKit

 //MARK: - UITableViewCell Class
class BusRouteTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceStationLabel: UILabel!
    @IBOutlet weak var sourceStationTimeLabel: UILabel!
    @IBOutlet weak var destinationStationLabel: UILabel!
    @IBOutlet weak var destinationStationTimeLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var tripTotalTimeLabel: UILabel!
    
    func configureCell(busRoute: BusRouteListModel) {
        sourceStationLabel.text = busRoute.source
        destinationStationLabel.text = busRoute.destination
        tripTotalTimeLabel.text = busRoute.tripDuration
        
        sourceStationTimeLabel.text = busRoute.tripStartTime
        destinationStationTimeLabel.text = Date.getFormattedDestinationTime(dateString: busRoute.tripStartTime ?? "")
        departureTimeLabel.text = Date.getDepartureDiff(time: busRoute.tripStartTime ?? "")
    }
}
