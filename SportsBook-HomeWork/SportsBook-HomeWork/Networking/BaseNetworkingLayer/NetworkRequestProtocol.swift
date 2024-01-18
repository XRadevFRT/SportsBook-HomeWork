//
//  NetworkRequestProtocol.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

protocol NetworkRequestProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var requiresAuthorization: Bool { get }
}


extension NetworkRequestProtocol {
    var baseURL: URL? {
        URL(string: "http://localhost:8080")
    }

    var headers: [String: String] {
        guard requiresAuthorization else {
            return [:]
        }
        return ["Authorization": "Bearer ewogICAibmFtZSI6ICJHdWVzdCIKfQ=="]
    }

    var parameters: [String: Any]? {
        nil
    }

    var requiresAuthorization: Bool {
        false
    }
}
