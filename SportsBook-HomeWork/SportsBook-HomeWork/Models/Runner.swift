//
//  Runner.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct Runner: Codable {
    let id: String
    let name: String?
    let totalGoals: Int?
    let marketType: MarketType
    let odds: Odds
}
