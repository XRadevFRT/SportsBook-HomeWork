//
//  GetEventsDataRequest.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import Foundation

struct GetEventsDataRequest: NetworkRequestProtocol {
    let sportId: Int

    var path: String {
        "/sports" +
        "/\(sportId)" +
        "/events"
    }

    var method: HTTPMethod {
        .get
    }

    var requiresAuthorization: Bool {
        true
    }
}
