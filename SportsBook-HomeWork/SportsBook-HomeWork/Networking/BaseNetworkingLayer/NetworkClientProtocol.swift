//
//  NetworkClientProtocol.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

protocol NetworkClientProtocol {
    func sendRequest<T: Decodable>(_ request: NetworkRequestProtocol,
                                   completion: @escaping (Result<T, NetworkError>) -> Void)
}
