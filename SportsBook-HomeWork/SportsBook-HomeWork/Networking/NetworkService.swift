//
//  NetworkService.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

typealias GetStatusCompletion = (Result<APIStatus, NetworkError>) -> Void
typealias GetSportsDataCompletion = (Result<SportsData, NetworkError>) -> Void
typealias GetEventsDataCompletion = (Result<EventsData, NetworkError>) -> Void

protocol GetStatusServiceProtocol {
    func getStatus(completion: @escaping GetStatusCompletion)
}

protocol GetSportsDataServiceProtocol {
    func getSportsData(completion: @escaping GetSportsDataCompletion)
}

protocol GetEventsDataServiceProtocol {
    func getEventsData(sportId: Int, completion: @escaping GetEventsDataCompletion)
}

final class NetworkService {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
}

// MARK: - GetStatusServiceProtocol

extension NetworkService: GetStatusServiceProtocol {
    func getStatus(completion: @escaping GetStatusCompletion) {
        let getStatusRequest = GetStatusRequest()
        networkClient.sendRequest(getStatusRequest, completion: completion)
    }
}

// MARK: - GetSportsDataServiceProtocol

extension NetworkService: GetSportsDataServiceProtocol {
    func getSportsData(completion: @escaping GetSportsDataCompletion) {
        let getSportsDataRequest = GetSportsDataRequest()
        networkClient.sendRequest(getSportsDataRequest, completion: completion)
    }
}

// MARK: - GetEventsDataServiceProtocol

extension NetworkService: GetEventsDataServiceProtocol {
    func getEventsData(sportId: Int, completion: @escaping GetEventsDataCompletion) {
        let getEventsDataRequest = GetEventsDataRequest(sportId: sportId)
        networkClient.sendRequest(getEventsDataRequest, completion: completion)
    }
}
