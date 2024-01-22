//
//  SportEventsListRouterTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 22.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class SportEventsListRouterTests: XCTestCase {
    private var mockPresentingViewController: MockPresentingViewController!
    private var mockOutput: MockSportEventsListRouterOutput!
    private var router: SportEventsListRouter!

    override func setUp() {
        super.setUp()
        mockPresentingViewController = MockPresentingViewController()
        mockOutput = MockSportEventsListRouterOutput()

        router = SportEventsListRouter(presentingViewController: mockPresentingViewController)
        router.output = mockOutput
    }

    override func tearDown() {
        mockPresentingViewController = nil
        router = nil
        mockOutput = nil
        super.tearDown()
    }

    func testShowFailedRequestAlert() {
        let expectation = expectation(description: "Correct Expectation")

        mockPresentingViewController.presentHandler = { viewController, animated, completion in
            XCTAssertTrue(animated)
            XCTAssertTrue(viewController is UIAlertController)
            let alertController = viewController as! UIAlertController

            XCTAssertEqual(alertController.title, "alertOopsTite".localized())
            XCTAssertEqual(alertController.message, "alertFailedAPICallMessage".localized())

            XCTAssertEqual(alertController.actions.count, 1)
            let alertAction = alertController.actions.first!
            XCTAssertEqual(alertAction.title, "alertRetryActionTitle".localized())
            XCTAssertEqual(alertAction.style, .default)

            completion?()
        }

        router.showFailedRequestAlert()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.2)


        XCTAssertEqual(mockPresentingViewController.presentCallCount, 1)
    }

    func testHandleRetryAction() {
        router.output = mockOutput
        router.handleRetryAction()

        XCTAssertEqual(mockOutput.didPressRetryCallCount, 1)
    }
}

private extension SportEventsListRouterTests {
    final class MockPresentingViewController: UIViewController {
        var presentCallCount = 0
        var presentHandler: ((UIViewController, Bool, (() -> Void)?) -> Void)?
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            presentCallCount += 1
            presentHandler?(viewControllerToPresent, flag, completion)
        }
    }

    final class MockSportEventsListRouterOutput: SportEventsListRouterOutput {
        var didPressRetryCallCount = 0
        func didPressRetry() {
            didPressRetryCallCount += 1
        }
    }
}
