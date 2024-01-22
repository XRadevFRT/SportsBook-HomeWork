//
//  SportEventsListBuilderTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 22.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class SportEventsListBuilderTests: XCTestCase {
    func testBuild() {
        let builder = SportEventsListBuilder(dependency: MockSportEventsListBuilderDependency())
        let viewController = builder.build(sport: .init(id: 1, name: ""))

        let sportListViewController = viewController as? SportEventsListViewController
        XCTAssertNotNil(sportListViewController)
        XCTAssertNotNil(sportListViewController?.output as? SportEventsListPresenter)

        let presenter = sportListViewController?.output as? SportEventsListPresenter
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.view)
        XCTAssertNotNil(presenter?.interactor)

        let interactor = presenter?.interactor as? SportEventsListInteractor
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.output as? SportEventsListPresenter)

        let router = presenter?.router as? SportEventsListRouter
        XCTAssertNotNil(router)
        XCTAssertNotNil(router?.output as? SportEventsListPresenter)
    }
}

private extension SportEventsListBuilderTests {
    final class MockSportEventsListBuilderDependency: SportEventsListBuilderDependency {
        var presentingViewController: UIViewController = .init()
        var getEventsDataService: GetEventsDataServiceProtocol = MockGetEventsDataService()
    }

    final class MockGetEventsDataService: GetEventsDataServiceProtocol {
        func getEventsData(sportId: Int, completion: @escaping GetEventsDataCompletion) {}
    }
}
