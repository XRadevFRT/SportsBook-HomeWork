//
//  OddsViewSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class OddsViewSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
        // isRecording = true
    }

    func testOddsViewWithSingleNumbers() {
        let oddsView = OddsView()
        oddsView.updateOddsLabel("5/3")

        assertSnapshots(of: SnapshotSupportContainer(oddsView, viewPosition: .centre, width: 100, height: 100), as: [.image])
    }

    func testOddsViewWithDoubleNumbers() {
        let oddsView = OddsView()
        oddsView.updateOddsLabel("15/10")

        assertSnapshots(of: SnapshotSupportContainer(oddsView, viewPosition: .centre, width: 100, height: 100), as: [.image])
    }

    func testOddsViewWithSingleNumbersAndDoubleNumber() {
        let oddsView = OddsView()
        oddsView.updateOddsLabel("2/10")

        assertSnapshots(of: SnapshotSupportContainer(oddsView, viewPosition: .centre, width: 100, height: 100), as: [.image])
    }
}
