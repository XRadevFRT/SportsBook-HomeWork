//
//  MainFlowModulePresenterTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class MainFlowModulePresenterTests: XCTestCase {
    private var mockRouter: MockRouter!
    private var presenter: MainFlowModulePresenter {
        .init(router: mockRouter)
    }

    override func setUp() {
        super.setUp()
        mockRouter = .init()
    }

    override func tearDown() {
        mockRouter = nil
        super.tearDown()
    }

    func testLaunch() {
        presenter.launch(from: .init(frame: .zero))
        XCTAssertEqual(mockRouter.showInitialScreenCallCount, 1)
    }

    func testStatusScreenFinished() {
        presenter.statusScreenFinished()
        XCTAssertEqual(mockRouter.showSportsListScreenCallCount, 1)
    }

    func testsSelectedSport() {
        let expectedSport = Sport.init(id: 22, name: "Tennis")

        mockRouter.showSportEventsListHandler = { sport in
            XCTAssertEqual(sport, expectedSport)
        }

        presenter.selectedSport(.init(id: 22, name: "Tennis"))

        XCTAssertEqual(mockRouter.showSportEventsListCallCount, 1)
    }
}

private extension MainFlowModulePresenterTests {
    final class MockRouter: MainFlowModuleRouterInput {
        var showSportEventsListCallCount = 0
        var showSportEventsListHandler: ((Sport) -> Void)?
        func showSportEventsList(sport: Sport) {
            showSportEventsListCallCount += 1
            showSportEventsListHandler?(sport)
        }
        
        var showSportsListScreenCallCount = 0
        func showSportsListScreen() {
            showSportsListScreenCallCount += 1
        }
        
        var showInitialScreenCallCount = 0
        func showInitialScreen(from window: UIWindow?) {
            showInitialScreenCallCount += 1
        }
    }
}
