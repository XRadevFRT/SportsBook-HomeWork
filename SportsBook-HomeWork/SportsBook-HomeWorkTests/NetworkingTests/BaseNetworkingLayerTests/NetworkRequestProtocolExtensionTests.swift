//
//  NetworkRequestProtocolExtensionTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 18.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

class NetworkRequestProtocolExtensionTests: XCTestCase {
    // Your existing tests for the mock implementation...

    func testDefaultBaseURL() {
        let mock = NetworkRequestProtocolTestMock()
        let expectedBaseURL = URL(string: "http://localhost:8080")

        // Action
        let baseURL = mock.baseURL

        // Test
        XCTAssertEqual(baseURL, expectedBaseURL)
    }

    func testDefaultHeadersWithoutAuthorization() {
        let mock = NetworkRequestProtocolTestMock()
        let expectedHeaders: [String: String] = [:]

        // Action
        let headers = mock.headers

        // Test
        XCTAssertEqual(headers, expectedHeaders)
    }

    func testDefaultHeadersWithAuthorization() {
        var mock = NetworkRequestProtocolTestMock()
        mock.mockRequiresAuthorization = true
        let expectedHeaders: [String: String] = ["Authorization": "Bearer ewogICAibmFtZSI6ICJHdWVzdCIKfQ=="]

        // Action
        let headers = mock.headers

        // Test
        XCTAssertEqual(headers, expectedHeaders)
    }

    func testRequiresAuthorizationDefault() {
        let mock = NetworkRequestProtocolDefaultAuthorizationTestMock()
        let expectedRequiresAuthorization = false

        // Action
        let requiresAuthorization = mock.requiresAuthorization

        // Test
        XCTAssertEqual(requiresAuthorization, expectedRequiresAuthorization)
    }

    func testDefaultParameters() {
        let mock = NetworkRequestProtocolTestMock()

        // Test
        XCTAssertNil(mock.parameters)
    }
}

private extension NetworkRequestProtocolExtensionTests {
    struct NetworkRequestProtocolTestMock: NetworkRequestProtocol {
        var path: String {
            return "/testPath"
        }

        var method: HTTPMethod {
            return .get
        }

        var mockRequiresAuthorization: Bool?
        var requiresAuthorization: Bool {
            guard let mockRequiresAuthorization = mockRequiresAuthorization else {
                return false
            }
            return mockRequiresAuthorization
        }
    }

    struct NetworkRequestProtocolDefaultAuthorizationTestMock: NetworkRequestProtocol {
        var path: String {
            ""
        }

        var method: SportsBook_HomeWork.HTTPMethod {
            .get
        }

    }
}
