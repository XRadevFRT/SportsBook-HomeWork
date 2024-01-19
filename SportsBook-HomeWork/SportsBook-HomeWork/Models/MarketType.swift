//
//  MarketType.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

enum MarketType: String, Codable {
    case winDrawWin = "WIN_DRAW_WIN"
    case matchBetting = "MATCH_BETTING"
    case totalGoalsInMatch = "TOTAL_GOALS_IN_MATCH"
}
