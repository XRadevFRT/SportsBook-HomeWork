//
//  EventDateViewSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 22.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class EventDateViewSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
         isRecording = true
    }

    func testEventDateView() {
        let eventDateView = EventDateView()
        eventDateView.updateEventDate("Saturday 13th January")
        assertSnapshot(of: SnapshotSupportContainer(eventDateView), as: .image)
    }
}
