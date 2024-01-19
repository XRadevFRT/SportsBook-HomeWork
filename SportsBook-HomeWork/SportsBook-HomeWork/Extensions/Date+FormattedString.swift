//
//  Date+FormattedString.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

extension Date {
    func formattedString() -> String {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"  // Day of the week

            let dayString = dayFormatter.string(from: self)

            let day = Calendar.current.component(.day, from: self)
            let dayOrdinal = NumberFormatter.ordinalNumberFormatter.string(from: NSNumber(value: day)) ?? ""

            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM"  // Month

            return "\(dayString) \(dayOrdinal) \(monthFormatter.string(from: self))"
        }
}
