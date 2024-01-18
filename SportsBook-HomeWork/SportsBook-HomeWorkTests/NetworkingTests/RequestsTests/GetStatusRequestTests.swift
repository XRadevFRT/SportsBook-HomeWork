//
//  GetStatusRequestTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 18.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class GetStatusRequestTests: XCTestCase {
    private var getStatusRequest: GetStatusRequest!

    override  func setUp() {
        super.setUp()
        getStatusRequest = .init()
    }

    override func tearDown() {
        getStatusRequest = nil
        super.tearDown()
    }

    func testGetStatusRequestPath() {
        XCTAssertEqual(getStatusRequest.path, "/status")
    }

    func testGetStatusRequestMethod() {
        XCTAssertEqual(getStatusRequest.method, .get)
    }

    func testGetStatusRequestDefaultValues() {
        XCTAssertEqual(getStatusRequest.baseURL, URL(string: "http://localhost:8080"))
        XCTAssertEqual(getStatusRequest.headers, [:])
        XCTAssertFalse(getStatusRequest.requiresAuthorization)
        XCTAssertNil(getStatusRequest.parameters)
    }
}
