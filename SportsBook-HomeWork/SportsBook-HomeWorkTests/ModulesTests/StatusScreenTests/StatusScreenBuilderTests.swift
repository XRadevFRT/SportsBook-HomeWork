//
//  StatusScreenBuilderTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class StatusScreenBuilderTests: XCTestCase {
    func testBuild() {
        let builder = StatusScreenBuilder(dependancy: MockStatusScreenBuilderDependency())
        let viewController = builder.build(handler: { })

        let statusScreenViewController = viewController as? StatusScreenViewController
        XCTAssertNotNil(statusScreenViewController)
        XCTAssertNotNil(statusScreenViewController?.output as? StatusScreenPresenter)

        let presenter = statusScreenViewController?.output as? StatusScreenPresenter
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.view)
        XCTAssertNotNil(presenter?.interactor)

        let interactor = presenter?.interactor as? StatusScreenInteractor
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.output as? StatusScreenPresenter)

        let router = presenter?.router as? StatusScreenRouter
        XCTAssertNotNil(router)
        XCTAssertNotNil(router?.output as? StatusScreenPresenter)
    }
}

private extension StatusScreenBuilderTests {
    final class MockStatusScreenBuilderDependency: StatusScreenBuilderDependency {
        var presentingViewController: UIViewController = .init()
        var getStatusService: GetStatusServiceProtocol = MockGetStatusScreen()
    }

    final class MockGetStatusScreen: GetStatusServiceProtocol {
        func getStatus(completion: @escaping SportsBook_HomeWork.GetStatusCompletion) {}
    }
}
