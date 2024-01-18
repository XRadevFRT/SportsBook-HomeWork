//
//  NetworkService.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

typealias GetStatusCompletion = (Result<APIStatus, NetworkError>) -> Void
protocol HasGetStatusService {
    func getStatus(completion: @escaping GetStatusCompletion)
}

final class NetworkService {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
}

extension NetworkService: HasGetStatusService {
    func getStatus(completion: @escaping GetStatusCompletion) {
        let getStatusRequest = GetStatusRequest()
        networkClient.sendRequest(getStatusRequest, completion: completion)
    }
}
