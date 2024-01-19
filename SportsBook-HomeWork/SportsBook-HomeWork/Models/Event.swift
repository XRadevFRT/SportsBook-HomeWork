//
//  Event.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct Event: Codable {
    let id: String
    let date: Date
    let name: String
    let primaryMarket: PrimaryMarket
}
