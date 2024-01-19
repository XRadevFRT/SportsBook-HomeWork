//
//  PrimaryMarket.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct PrimaryMarket: Codable {
    let id: String
    let name: String
    let type: String
    let runners: [Runner]
}
