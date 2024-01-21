//
//  SportsListViewControllerSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class SportsListViewControllerSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
//         isRecording = true
    }

    func testSportListViewController() {
        let mockedSports: [Sport] = [
            .init(id: 1, name: "Football"),
            .init(id: 2, name: "Rugby"),
            .init(id: 3, name: "Basketball"),
            .init(id: 4, name: "Tennis"),
            .init(id: 5, name: "Volleyball")
        ]

        let vc = SportsListViewController()
        vc.updateUI(sports: mockedSports)

        assertSnapshots(of: vc, as: [.image])
    }
}
