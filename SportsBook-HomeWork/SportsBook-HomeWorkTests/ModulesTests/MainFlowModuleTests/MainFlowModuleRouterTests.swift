//
//  MainFlowModuleRouterTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class MainFlowModuleRouterTests: XCTestCase {
    private var mockUINavigationController: MockUINavigationController!
    private var mockUIWindow: MockUIWindow!
    private var router: MainFlowModuleRouter!


    override func setUp() {
        super.setUp()
        mockUINavigationController = .init()
        mockUIWindow = .init()
        router = MainFlowModuleRouter(mainNavigationController: mockUINavigationController)
    }

    override func tearDown() {
        mockUINavigationController = nil
        mockUIWindow = nil
        router = nil
    }

    func testShowInitialScreen() {
        router.showInitialScreen(from: mockUIWindow)

        // Test
        XCTAssertEqual(mockUINavigationController.viewControllersSetCallCount, 1)
        XCTAssertEqual(mockUIWindow.rootViewControllerSetCallCount, 1)
        XCTAssertEqual(mockUIWindow.makeKeyAndVisibleCallCount, 1)
    }
}

private extension MainFlowModuleRouterTests {
    final class MockUINavigationController: UINavigationController {
        var viewControllersSetCallCount = 0
        override var viewControllers: [UIViewController] {
            didSet {
                viewControllersSetCallCount += 1
            }
        }
    }

    final class MockUIWindow: UIWindow {
        var rootViewControllerSetCallCount = 0
        override var rootViewController: UIViewController? {
            didSet {
                rootViewControllerSetCallCount += 1
            }
        }

        var makeKeyAndVisibleCallCount = 0
        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount += 1
        }
    }
}
