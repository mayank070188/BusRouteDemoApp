//
//  Date+Utils.swift
//  BusRoute
//
//  Created by Mayank Mathur on 24/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import Foundation

enum DateFormatString: String {
    /// Format: h:mma
    /// example: 5:18
    case timeHourMinute = "HH:mm"
}

extension Date {
    
    private static let dateFormatter: DateFormatter = {
        return DateFormatter()
    }()
    
    static func getFormattedDestinationTime(dateString: String) -> String {
    
        dateFormatter.dateFormat = DateFormatString.timeHourMinute.rawValue
        let timeString = Calendar.current.dateComponents([.hour, .minute], from:dateFormatter.date(from:dateString)!)
        let tempDate = Calendar.current.nextDate(after: Date(), matching: timeString, matchingPolicy: .nextTime)!
        let currentDay = Calendar.current.date(byAdding: .day, value: -1, to: tempDate)
        
        // Adding 45 minutes to all destination time for the sake of Demo app
        let destinationDate = Calendar.current.date(byAdding: .minute, value: 45, to: currentDay!)

        return dateFormatter.string(from:destinationDate!)
    }
    
    static func getDepartureDiff(time: String) -> String {
        
        dateFormatter.dateFormat = DateFormatString.timeHourMinute.rawValue
        let timeString = Calendar.current.dateComponents([.hour, .minute], from:dateFormatter.date(from:time)!)
        let currentDay = Calendar.current.nextDate(after: Date(), matching: timeString, matchingPolicy: .nextTime)!
        
        let diff = currentDay.minutes(from: Date())
        
        if diff == 0 {
            return "Now"
        } else {
            return String(diff)
        }
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
}
