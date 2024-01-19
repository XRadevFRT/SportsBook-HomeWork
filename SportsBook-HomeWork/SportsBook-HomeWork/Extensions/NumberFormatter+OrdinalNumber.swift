//
//  NumberFormatter+OrdinalNumber.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import Foundation

extension NumberFormatter {
    static var ordinalNumberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }
}
