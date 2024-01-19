//
//  GetEventsDataRequestTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class GetEventsDataRequestTests: XCTestCase {

    func testGetEventsDataRequestPath() {
        let getEventsDataRequest = buildGetEventsDataRequest(sportId: 1)
        XCTAssertEqual(getEventsDataRequest.path, "/sports/1/events")
    }

    func testGetEventsDataRequestMethod() {
        let getEventsDataRequest = buildGetEventsDataRequest(sportId: 2)
        XCTAssertEqual(getEventsDataRequest.method, .get)
    }

    func testGetEventsDataRequestAuthorizationRequirement() {
        let getEventsDataRequest = buildGetEventsDataRequest(sportId: 3)
        XCTAssertTrue(getEventsDataRequest.requiresAuthorization)
    }

    func testGetEventsDataRequestHeaders() {
        let getEventsDataRequest = buildGetEventsDataRequest(sportId: 4)
        let expectedHeaders: [String: String] = ["Authorization": "Bearer ewogICAibmFtZSI6ICJHdWVzdCIKfQ=="]

        XCTAssertEqual(getEventsDataRequest.headers, expectedHeaders)
    }

    func testGetEventsDataRequestDefaultValues() {
        let getEventsDataRequest = buildGetEventsDataRequest(sportId: 4)
        XCTAssertEqual(getEventsDataRequest.baseURL, URL(string: "http://localhost:8080"))
        XCTAssertNil(getEventsDataRequest.parameters)
    }

    private func buildGetEventsDataRequest(sportId: Int) -> GetEventsDataRequest {
        .init(sportId: sportId)
    }
}
