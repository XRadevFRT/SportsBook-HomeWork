//
//  SportsListPresenterTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class SportsListPresenterTests: XCTestCase {
    private var mockView: MockStatusScreenViewController!
    private var mockInteractor: MockSportsListInteractor!
    private var mockRouter: MockSportsListRouter!

    private var completionHandlerCallCount = 0
    private var completionHandlerResult: SportsListResult?
    private var completionHandler: SportsListBuilderCompletionHandler! = { _ in }

    private var presenter: SportsListPresenter {
        .init(view: mockView,
              interactor: mockInteractor,
              router: mockRouter,
              completionHandler: completionHandler)
    }

    override func setUp() {
        super.setUp()
        mockView = .init()
        mockInteractor = .init()
        mockRouter = .init()
        completionHandler = { result in
            self.completionHandlerCallCount += 1
            self.completionHandlerResult = result
        }
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        completionHandler = nil
        completionHandlerResult = nil
        completionHandlerCallCount = 0
        super.tearDown()
    }

    func testViewIsReady() {
        presenter.viewIsReady()

        XCTAssertEqual(mockView.startActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockInteractor.getSportsListCallCount, 1)
    }

    func testDidSelectSport() {
        let expectedSport = Sport(id: 100, name: "Rugby")

        presenter.didSelectSport(.init(id: 100, name: "Rugby"))

        XCTAssertEqual(completionHandlerCallCount, 1)
        XCTAssertEqual(completionHandlerResult, .sportSelected(expectedSport))
    }

    func testGetSportSuccess() {
        let expectedSports: [Sport] = [.init(id: 150, name: "Football")]

        mockView.updateUIHandler = { sports in
            XCTAssertEqual(sports, expectedSports)
        }

        presenter.getSportsSuccess([.init(id: 150, name: "Football")])

        XCTAssertEqual(mockView.updateUICallCount, 1)
        XCTAssertEqual(mockView.stopActivityIndicatorCallCount, 1)
    }

    func testGetSportsFailed() {
        presenter.getSportsFailed()

        XCTAssertEqual(mockView.stopActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockRouter.showFailedRequestAlertCallCount, 1)
    }

    func testDidPressRetry() {
        presenter.didPressRetry()

        XCTAssertEqual(mockView.startActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockInteractor.getSportsListCallCount, 1)
    }
}

private extension SportsListPresenterTests {
    final class MockStatusScreenViewController: SportsListViewControllerInput {
        var startActivityIndicatorCallCount = 0
        func startActivityIndicator() {
            startActivityIndicatorCallCount += 1
        }

        var stopActivityIndicatorCallCount = 0
        func stopActivityIndicator() {
            stopActivityIndicatorCallCount += 1
        }

        var updateUICallCount = 0
        var updateUIHandler: (([Sport]) -> Void)?
        func updateUI(sports: [Sport]) {
            updateUICallCount += 1
            updateUIHandler?(sports)
        }
    }

    final class MockSportsListInteractor: SportsListInteractorInput {
        var getSportsListCallCount = 0
        func getSportsList() {
            getSportsListCallCount += 1
        }
    }

    final class MockSportsListRouter: SportsListRouterInput {
        var showFailedRequestAlertCallCount = 0
        func showFailedRequestAlert() {
            showFailedRequestAlertCallCount += 1
        }
    }
}
