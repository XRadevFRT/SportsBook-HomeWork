//
//  GetStatusRequest.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct GetStatusRequest: NetworkRequestProtocol {
    var path: String {
        "/status"
    }

    var method: HTTPMethod {
        .get
    }
}
