//
//  NetworkServiceTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 18.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class NetworkServiceTests: XCTestCase {
    private var mockNetworkClient: MockNetworkClient!
    private var networkService: NetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        networkService = .init(networkClient: mockNetworkClient)
    }

    override func tearDown() {
        mockNetworkClient = nil
        networkService = nil
        super.tearDown()
    }

    func testGetStatusSuccess() {
        let expectation = XCTestExpectation(description: "Get status completion called")

        networkService.getStatus { _ in
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(mockNetworkClient.sendRequestCallCount, 1)
        XCTAssert(mockNetworkClient.sendRequest is GetStatusRequest)
    }
}

private extension NetworkServiceTests {
    class MockNetworkClient: NetworkClientProtocol {
        var sendRequestCallCount = 0
        var sendRequest: NetworkRequestProtocol?

        func sendRequest<T: Decodable>(_ request: NetworkRequestProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) {
            sendRequestCallCount += 1
            sendRequest = request

            completion(.failure(.unexpectedResponse))
        }
    }
}
