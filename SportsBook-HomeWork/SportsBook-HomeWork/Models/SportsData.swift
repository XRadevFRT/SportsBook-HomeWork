//
//  SportsData.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct SportsData: Decodable {
    let sports: [Sport]

    enum CodingKeys: String, CodingKey {
        case sports = "data"
    }
}

struct Sport: Decodable, Equatable {
    let id: Int
    let name: String
}
