//
//  MainFlowModuleBuilderTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class MainFlowModuleBuilderTests: XCTestCase {
    func testBuild() {
        let builder = MainFlowModuleBuilder()
        let mainFlowModuleInput = builder.build()

        XCTAssertTrue(mainFlowModuleInput is MainFlowModulePresenter)

        let presenter = mainFlowModuleInput as! MainFlowModulePresenter

        XCTAssertNotNil(presenter.router)
        XCTAssertTrue(presenter.router is MainFlowModuleRouter)
    }
}
