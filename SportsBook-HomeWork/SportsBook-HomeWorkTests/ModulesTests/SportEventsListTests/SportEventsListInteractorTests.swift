//
//  SportEventsListInteractorTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 22.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class SportEventsListInteractorTests: XCTestCase {
    private var mockInteractorOutput: MockSportEventsListInteractorOutput!
    private var mockGetEventsDataService: MockGetEventsDataService!
    private var interactor: SportEventsListInteractor {
        let interactor = SportEventsListInteractor(getEventsDataService: mockGetEventsDataService)
        interactor.output = mockInteractorOutput
        return interactor
    }

    override func setUp() {
        super.setUp()
        mockInteractorOutput = .init()
        mockGetEventsDataService = .init()
    }

    override func tearDown() {
        mockGetEventsDataService = nil
        mockInteractorOutput = nil
        super.tearDown()
    }

    func testGetSportEventsSuccess() {
        let expectedSportId = 321
        let primaryMarket = PrimaryMarket(id: "", name: "", type: .matchBetting, runners: [])
        let event = Event(id: "332211", date: Date(), name: "", primaryMarket: primaryMarket)

        mockGetEventsDataService.getEventsDataHandler = { sportId in
            XCTAssertEqual(sportId, expectedSportId)
            return .success(.init(data: [event]))
        }

        mockInteractorOutput.getSportEventsSuccessHandler = { events in
            XCTAssertEqual(events[0].events[0].id, "332211")
        }

        interactor.getEventsData(for: 321)

        XCTAssertEqual(mockInteractorOutput.getSportEventsSuccessCallCount, 1)
    }

    func testGetSportEventsFailed() {
        let expectedSportId = 123

        mockGetEventsDataService.getEventsDataHandler = { sportId in
            XCTAssertEqual(sportId, expectedSportId)
            return .failure(.unexpectedResponse)
        }

        interactor.getEventsData(for: 123)

        XCTAssertEqual(mockInteractorOutput.getSportEventsFailedCallCount, 1)
    }
}

private extension SportEventsListInteractorTests {
    final class MockSportEventsListInteractorOutput: SportEventsListInteractorOutput {
        var getSportEventsSuccessCallCount = 0
        var getSportEventsSuccessHandler: (([EventDay]) -> Void)?
        func getSportEventsSuccess(_ result: [EventDay]) {
            getSportEventsSuccessCallCount += 1
            if let getSportEventsSuccessHandler = getSportEventsSuccessHandler {
                getSportEventsSuccessHandler(result)
            }
        }

        var getSportEventsFailedCallCount = 0
        func getSportEventsFailed() {
            getSportEventsFailedCallCount += 1
        }
    }

    final class MockGetEventsDataService: GetEventsDataServiceProtocol {
        var getEventsDataCallCount = 0
        var getEventsDataHandler: ((Int) -> Result<EventsData, NetworkError>)?
        func getEventsData(sportId: Int, completion: @escaping GetEventsDataCompletion) {
            getEventsDataCallCount += 1
            if let getEventsDataHandler = getEventsDataHandler {
                completion(getEventsDataHandler(sportId))
            }
        }
    }
}
