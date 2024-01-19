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

protocol HasGetStatusService {
    func getStatus(completion: @escaping GetStatusCompletion)
}

protocol HasGetSportsDataService {
    func getSportsData(completion: @escaping GetSportsDataCompletion)
}

protocol HasGetEventsDataService {
    func getEventsData(sportId: Int, completion: @escaping GetEventsDataCompletion)
}

final class NetworkService {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
}

// MARK: - HasGetStatusService
extension NetworkService: HasGetStatusService {
    func getStatus(completion: @escaping GetStatusCompletion) {
        let getStatusRequest = GetStatusRequest()
        networkClient.sendRequest(getStatusRequest, completion: completion)
    }
}

// MARK: - HasGetSportsDataService
extension NetworkService: HasGetSportsDataService {
    func getSportsData(completion: @escaping GetSportsDataCompletion) {
        let getSportsDataRequest = GetSportsDataRequest()
        networkClient.sendRequest(getSportsDataRequest, completion: completion)
    }
}

// MARK: - HasGetEventsDataService
extension NetworkService: HasGetEventsDataService {
    func getEventsData(sportId: Int, completion: @escaping GetEventsDataCompletion) {
        let getEventsDataRequest = GetEventsDataRequest(sportId: sportId)
        networkClient.sendRequest(getEventsDataRequest, completion: completion)
    }
}
