//
//  SportsListBuilderTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class SportsListBuilderTests: XCTestCase {
    func testBuild() {
        let builder = SportsListBuilder(dependency: MockSportsListBuilderDependency())
        let viewController = builder.build(handler: { _ in })

        let sportListViewController = viewController as? SportsListViewController
        XCTAssertNotNil(sportListViewController)
        XCTAssertNotNil(sportListViewController?.output as? SportsListPresenter)

        let presenter = sportListViewController?.output as? SportsListPresenter
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.view)
        XCTAssertNotNil(presenter?.interactor)

        let interactor = presenter?.interactor as? SportsListInteractor
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.output as? SportsListPresenter)

        let router = presenter?.router as? SportsListRouter
        XCTAssertNotNil(router)
        XCTAssertNotNil(router?.output as? SportsListPresenter)
    }
}

private extension SportsListBuilderTests {
    final class MockSportsListBuilderDependency: SportsListBuilderDependency {
        var presentingViewController: UIViewController = .init()
        var getSportsListService: GetSportsDataServiceProtocol = MockGetSportsDataService()
    }

    final class MockGetSportsDataService: GetSportsDataServiceProtocol {
        func getSportsData(completion: @escaping GetSportsDataCompletion) {}
    }
}
