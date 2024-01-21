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
    private var mockMainFlowRouterOutput: MockMainFlowRouterOutput!
    private var mockStatusScreenBuilder: MockStatusScreenBuilder!
    private var mockSportsListBuilder: MockSportsListBuilder!
    private var mockUIWindow: MockUIWindow!
    private var router: MainFlowModuleRouter!


    override func setUp() {
        super.setUp()
        mockUINavigationController = .init()
        mockMainFlowRouterOutput = .init()
        mockUIWindow = .init()
        mockStatusScreenBuilder = .init()
        mockSportsListBuilder = .init()
        router = MainFlowModuleRouter(statusScreenBuilder: mockStatusScreenBuilder,
                                      sportsListBuilder: mockSportsListBuilder,
                                      mainNavigationController: mockUINavigationController)
        router.output = mockMainFlowRouterOutput
    }

    override func tearDown() {
        mockUINavigationController = nil
        mockMainFlowRouterOutput = nil
        mockStatusScreenBuilder = nil
        mockSportsListBuilder = nil
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

    func testInitialScreenHandler() {
        router.showInitialScreen(from: mockUIWindow)
        mockStatusScreenBuilder.capturedHandler!()

        // Test
        XCTAssertEqual(mockUINavigationController.viewControllersSetCallCount, 1)
        XCTAssertEqual(mockUIWindow.rootViewControllerSetCallCount, 1)
        XCTAssertEqual(mockUIWindow.makeKeyAndVisibleCallCount, 1)
        XCTAssertEqual(mockMainFlowRouterOutput.statusScreenFinishedCallCount, 1)
    }

    func testShowSportsListScreen() {
        router.showSportsListScreen()

        // Test
        XCTAssertEqual(mockUINavigationController.viewControllersSetCallCount, 1)
    }

    func testSportsListHandler() {
        mockSportsListBuilder.buildHandler = { result in
            result(.sportSelected(10))
            return .init()
        }

        mockMainFlowRouterOutput.selectedSportHandler = { sportId in
            XCTAssertEqual(sportId, 10)
        }

        router.showSportsListScreen()

        // Test
        XCTAssertEqual(mockUINavigationController.viewControllersSetCallCount, 1)
        XCTAssertEqual(mockMainFlowRouterOutput.selectedSportCallCount, 1)
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

        var pushViewControllerCallCount = 0
        var pushViewControllerHandler: ((UIViewController, Bool) -> Void)?
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushViewControllerCallCount += 1
            if let pushViewControllerHandler = pushViewControllerHandler {
                pushViewControllerHandler(viewController, animated)
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

    final class MockMainFlowRouterOutput: MainFlowRouterOutput {
        var selectedSportCallCount = 0
        var selectedSportHandler: ((Int) -> Void)?
        func selectedSport(_ sportId: Int) {
            selectedSportCallCount += 1
            if let selectedSportHandler = selectedSportHandler {
                selectedSportHandler(sportId)
            }
        }

        var statusScreenFinishedCallCount = 0
        func statusScreenFinished() {
            statusScreenFinishedCallCount += 1
        }
    }

    final class MockStatusScreenBuilder: StatusScreenBuildable {
        var buildCallCount = 0
        var capturedHandler: StatusScreenBuilderCompletionHandler?
        func build(handler: @escaping StatusScreenBuilderCompletionHandler) -> UIViewController {
            buildCallCount += 1
            capturedHandler = handler
            return .init()
        }
    }

    final class MockSportsListBuilder: SportsListBuildable {
        var buildCallCount = 0
        var buildHandler: ((SportsListBuilderCompletionHandler) -> UIViewController)?
        func build(handler: @escaping SportsListBuilderCompletionHandler) -> UIViewController {
            buildCallCount += 1
            if let buildHandler = buildHandler {
                return buildHandler(handler)
            }
            return .init()
        }
    }
}
