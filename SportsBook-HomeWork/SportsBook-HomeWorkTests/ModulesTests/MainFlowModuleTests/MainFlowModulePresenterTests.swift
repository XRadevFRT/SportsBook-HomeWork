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
}

private extension MainFlowModulePresenterTests {
    final class MockRouter: MainFlowModuleRouterInput {
        var showInitialScreenCallCount = 0
        func showInitialScreen(from window: UIWindow?) {
            showInitialScreenCallCount += 1
        }
    }
}
