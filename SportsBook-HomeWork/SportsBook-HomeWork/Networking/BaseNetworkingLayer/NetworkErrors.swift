//
//  NetworkErrors.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(statusCode: Int, data: Data?)
    case encodingFailed
    case decodingFailed
    case unexpectedResponse
}
