//
//  StatusScreenRouterTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class StatusScreenRouterTests: XCTestCase {
    private var mockPresentingViewController: MockPresentingViewController!
    private var mockOutput: MockStatusScreenRouterOutput!
    private var router: StatusScreenRouter!

    override func setUp() {
        super.setUp()
        mockPresentingViewController = MockPresentingViewController()
        mockOutput = MockStatusScreenRouterOutput()

        router = StatusScreenRouter(presentingViewController: mockPresentingViewController)
        router.output = mockOutput
    }

    override func tearDown() {
        mockPresentingViewController = nil
        router = nil
        mockOutput = nil
        super.tearDown()
    }

    func testShowBadAPIStatusAlert() {
        let expectation = expectation(description: "Correct Expectation")

        mockPresentingViewController.presentHandler = { viewController, animated, completion in
            XCTAssertTrue(animated)
            XCTAssertTrue(viewController is UIAlertController)
            let alertController = viewController as! UIAlertController

            XCTAssertEqual(alertController.title, "Oops...")
            XCTAssertEqual(alertController.message, "It seems something is wrong with the local API. Please restart the API and try again")

            XCTAssertEqual(alertController.actions.count, 1)
            let alertAction = alertController.actions.first!
            XCTAssertEqual(alertAction.title, "Retry")
            XCTAssertEqual(alertAction.style, .default)

            completion?()
        }

        router.showBadAPIStatusAlert()

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

private extension StatusScreenRouterTests {
    final class MockPresentingViewController: UIViewController {
        var presentCallCount = 0
        var presentHandler: ((UIViewController, Bool, (() -> Void)?) -> Void)?
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            presentCallCount += 1
            presentHandler?(viewControllerToPresent, flag, completion)
        }
    }

    final class MockStatusScreenRouterOutput: StatusScreenRouterOutput {
        var didPressRetryCallCount = 0
        func didPressRetry() {
            didPressRetryCallCount += 1
        }
    }
}
