//
//  BaseSportViewSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class BaseSportViewSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
//         isRecording = true
    }

    func testBaseSportViewDefault() {
        let baseSportView = BaseSportView()
        baseSportView.updateTitle("Football")

        assertSnapshots(of: SnapshotSupportContainer(baseSportView), as: [.image])
    }

    func testBaseSportViewWithUnknownSportName() {
        let baseSportView = BaseSportView()
        baseSportView.updateTitle("")

        assertSnapshots(of: SnapshotSupportContainer(baseSportView), as: [.image])
    }
}
