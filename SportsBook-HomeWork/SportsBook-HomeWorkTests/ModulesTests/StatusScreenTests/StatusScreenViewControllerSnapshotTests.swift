//
//  StatusScreenViewControllerSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 19.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class StatusScreenViewControllerSnapshotTests: XCTestCase {
    override class func setUp() {
            super.setUp()

            // Set TRUE when creating images, FALSE when you test
            // isRecording = true
        }
    func testStatusScreenViewController() {
        let vc = StatusScreenViewController()
        assertSnapshots(of: vc, as: [.image])
    }
}
