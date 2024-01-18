//
//  GetStatusRequestTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 18.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class GetStatusRequestTests: XCTestCase {
    func testGetStatusRequestPath() {
        let getStatusRequest = GetStatusRequest()
        XCTAssertEqual(getStatusRequest.path, "/status")
    }

    func testGetStatusRequestMethod() {
        let getStatusRequest = GetStatusRequest()
        XCTAssertEqual(getStatusRequest.method, .get)
    }

    func testGetStatusRequestDefaultValues() {
        let getStatusRequest = GetStatusRequest()
        XCTAssertEqual(getStatusRequest.baseURL, URL(string: "http://localhost:8080"))
        XCTAssertEqual(getStatusRequest.headers, [:])
        XCTAssertFalse(getStatusRequest.requiresAuthorization)
        XCTAssertNil(getStatusRequest.parameters)
    }
}
