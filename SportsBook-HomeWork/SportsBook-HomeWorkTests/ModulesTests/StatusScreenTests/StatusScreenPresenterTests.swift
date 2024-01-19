//
//  StatusScreenPresenterTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class StatusScreenPresenterTests: XCTestCase {
    private var mockView: MockStatusScreenViewController!
    private var mockInteractor: MockStatusScreenInteractor!
    private var mockrouter: MockStatusScreenRouter!

    private var completionHandlerCallCount = 0
    private var completionHandler: StatusScreenBuilderCompletionHandler! = {}

    private var presenter: StatusScreenPresenter {
        .init(view: mockView,
              interactor: mockInteractor,
              router: mockrouter,
              completionHandler: completionHandler)
    }

    override func setUp() {
        super.setUp()
        mockView = .init()
        mockInteractor = .init()
        mockrouter = .init()
        completionHandler = {
            self.completionHandlerCallCount += 1
        }
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockrouter = nil
        completionHandler = nil
        completionHandlerCallCount = 0
        super.tearDown()
    }

    func testViewIsReady() {
        presenter.viewIsReady()

        XCTAssertEqual(mockView.startActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockInteractor.getAPIStatusCallCount, 1)
    }

    func testGetAPIStatusSuccessWithOKStatus() {
        presenter.getAPIStatusSuccess(.init(status: "OK"))

        XCTAssertEqual(mockView.stopActivityIndicatorCallCount, 1)
        XCTAssertEqual(completionHandlerCallCount, 1)
    }

    func testGetAPIStatusSuccessWithBadStatus() {
        presenter.getAPIStatusSuccess(.init(status: "NOT OK"))

        XCTAssertEqual(mockView.stopActivityIndicatorCallCount, 1)
        XCTAssertEqual(completionHandlerCallCount, 0)
        XCTAssertEqual(mockrouter.showBadAPIStatusAlertCallCount, 1)
    }

    func testGetAPIStatusFailed() {
        presenter.getAPIStatusFailed()

        XCTAssertEqual(mockView.stopActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockrouter.showBadAPIStatusAlertCallCount, 1)
    }

    func testDidPressRetry() {
        presenter.didPressRetry()

        XCTAssertEqual(mockView.startActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockInteractor.getAPIStatusCallCount, 1)
    }
}

private extension StatusScreenPresenterTests {
    final class MockStatusScreenViewController: StatusScreenViewControllerInput {
        var startActivityIndicatorCallCount = 0
        func startActivityIndicator() {
            startActivityIndicatorCallCount += 1
        }
        
        var stopActivityIndicatorCallCount = 0
        func stopActivityIndicator() {
            stopActivityIndicatorCallCount += 1
        }
    }

    final class MockStatusScreenInteractor: StatusScreenInteractorInput {
        var getAPIStatusCallCount = 0
        func getAPIStatus() {
            getAPIStatusCallCount += 1
        }
    }

    final class MockStatusScreenRouter: StatusScreenRouterInput {
        var showBadAPIStatusAlertCallCount = 0
        func showBadAPIStatusAlert() {
            showBadAPIStatusAlertCallCount += 1
        }
    }
}
