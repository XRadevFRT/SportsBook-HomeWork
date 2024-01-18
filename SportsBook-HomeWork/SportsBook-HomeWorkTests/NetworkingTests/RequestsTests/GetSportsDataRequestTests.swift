//
//  GetSportsDataRequestTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 18.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class GetSportsDataRequestTests: XCTestCase {
    private var getSportsDataRequest: GetSportsDataRequest!

    override func setUp() {
        super.setUp()
        getSportsDataRequest = .init()
    }

    override func tearDown() {
        getSportsDataRequest = nil
        super.tearDown()
    }

    func testGetSportsDataRequestPath() {
        XCTAssertEqual(getSportsDataRequest.path, "/sports")
    }

    func testGetSportsDataRequestMethod() {
        XCTAssertEqual(getSportsDataRequest.method, .get)
    }

    func testGetSportsDataRequestAuthorizationRequirement() {
        XCTAssertTrue(getSportsDataRequest.requiresAuthorization)
    }

    func testGetSportsDataRequestHeaders() {
        let expectedHeaders: [String: String] = ["Authorization": "Bearer ewogICAibmFtZSI6ICJHdWVzdCIKfQ=="]
        XCTAssertEqual(getSportsDataRequest.headers, expectedHeaders)
    }

    func testGetSportsDataRequestDefaultValues() {
        XCTAssertEqual(getSportsDataRequest.baseURL, URL(string: "http://localhost:8080"))
        XCTAssertNil(getSportsDataRequest.parameters)
    }
}
