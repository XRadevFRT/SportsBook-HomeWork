//
//  SportsListInteractorTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class SportsListInteractorTests: XCTestCase {
    private var mockInteractorOutput: MockSportsListInteractorOutput!
    private var mockGetSportsDataService: MockGetSportsDataService!
    private var interactor: SportsListInteractor {
        let interactor = SportsListInteractor(getSportsListService: mockGetSportsDataService)
        interactor.output = mockInteractorOutput
        return interactor
    }

    override func setUp() {
        super.setUp()
        mockInteractorOutput = .init()
        mockGetSportsDataService = .init()
    }

    override func tearDown() {
        mockGetSportsDataService = nil
        mockInteractorOutput = nil
        super.tearDown()
    }

    func testGetSportListSuccess() {
        let expectedSports: [Sport] = [.init(id: 1, name: "Football")]

        mockGetSportsDataService.getSportsDataHandler = {
            return .success(.init(sports: [.init(id: 1, name: "Football")]))
        }

        mockInteractorOutput.getSportsSuccessResult = { result in
            XCTAssertEqual(result, expectedSports)
        }

        interactor.getSportsList()

        XCTAssertEqual(mockInteractorOutput.getSportsSuccessCallCount, 1)
    }

    func testGetSportListFailure() {
        mockGetSportsDataService.getSportsDataHandler = {
            return .failure(.unexpectedResponse)
        }

        interactor.getSportsList()

        XCTAssertEqual(mockInteractorOutput.getSportsFailedCallCount, 1)
    }
}

private extension SportsListInteractorTests {
    final class MockSportsListInteractorOutput: SportsListInteractorOutput {
        var getSportsSuccessCallCount = 0
        var getSportsSuccessResult: (([Sport]) -> ())?
        func getSportsSuccess(_ result: [Sport]) {
            getSportsSuccessCallCount += 1
            getSportsSuccessResult?(result)
        }
        
        var getSportsFailedCallCount = 0
        func getSportsFailed() {
            getSportsFailedCallCount += 1
        }
    }

    final class MockGetSportsDataService: GetSportsDataServiceProtocol {
        var getSportsDataCallCount = 0
        var getSportsDataHandler: (() -> Result<SportsData, NetworkError>)?
        func getSportsData(completion: @escaping GetSportsDataCompletion) {
            getSportsDataCallCount += 1
            if let getSportsDataHandler = getSportsDataHandler {
                completion(getSportsDataHandler())
            }
        }
    }
}
