//
//  GetSportsDataRequest.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct GetSportsDataRequest: NetworkRequestProtocol {
    var path: String {
        "/sports"
    }

    var method: HTTPMethod {
        .get
    }

    var requiresAuthorization: Bool {
        true
    }
}
