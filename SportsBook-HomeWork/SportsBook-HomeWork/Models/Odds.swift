//
//  Odds.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct Odds: Codable {
    let numerator: Int
    let denominator: Int
}

extension Odds {
    var text: String {
        "\(numerator)/\(denominator)"
    }
}
