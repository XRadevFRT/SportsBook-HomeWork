//
//  StatusScreenInteractorTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class StatusScreenInteractorTests: XCTestCase {
    private var mockInteractorOutput: MockStatusScreenInteractorOutput!
    private var mockGetStatusService: MockGetStatusService!
    private var interactor: StatusScreenInteractor {
        let interactor = StatusScreenInteractor(getStatusService: mockGetStatusService)
        interactor.output = mockInteractorOutput
        return interactor
    }

    override func setUp() {
        super.setUp()
        mockInteractorOutput = .init()
        mockGetStatusService = .init()
    }

    override func tearDown() {
        mockGetStatusService = nil
        mockInteractorOutput = nil
        super.tearDown()
    }

    func testGetAPIStatusSuccess() {
        mockGetStatusService.getStatusHandler = {
            return .success(.init(status: "OK"))
        }
        mockInteractorOutput.getAPIStatusSuccessResult = { result in
            XCTAssertEqual(result.status, "OK")
        }

        interactor.getAPIStatus()

        XCTAssertEqual(mockInteractorOutput.getAPIStatusSuccessCallCount, 1)
    }

    func testGetAPIStatusFailure() {
        mockGetStatusService.getStatusHandler = {
            return .failure(.unexpectedResponse)
        }

        interactor.getAPIStatus()

        XCTAssertEqual(mockInteractorOutput.getAPIStatusFailedCallCount, 1)
    }
}

private extension StatusScreenInteractorTests {
    final class MockStatusScreenInteractorOutput: StatusScreenInteractorOutput {
        var getAPIStatusSuccessCallCount = 0
        var getAPIStatusSuccessResult: ((APIStatus) -> ())?
        func getAPIStatusSuccess(_ result: APIStatus) {
            getAPIStatusSuccessCallCount += 1
            getAPIStatusSuccessResult?(result)
        }
        
        var getAPIStatusFailedCallCount = 0
        func getAPIStatusFailed() {
            getAPIStatusFailedCallCount += 1
        }
    }

    final class MockGetStatusService: GetStatusServiceProtocol {
        var getStatusHandler: (() -> Result<APIStatus, NetworkError>)?
        var getStatusCallCount = 0
        func getStatus(completion: @escaping GetStatusCompletion) {
            getStatusCallCount += 1
            if let getStatusHandler = getStatusHandler {
                completion(getStatusHandler())
            }
        }
    }
}
