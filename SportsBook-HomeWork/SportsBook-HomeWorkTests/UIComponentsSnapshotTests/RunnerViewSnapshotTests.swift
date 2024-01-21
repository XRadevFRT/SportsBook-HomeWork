//
//  RunnerViewSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class RunnerViewSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
        // isRecording = true
    }

    func testRunnerViewSingleNumbersHome() {
        let runnerViewModel = RunnerView.ViewModel(title: "Home", odds: "5/3")
        let runnerView = RunnerView()
        runnerView.update(with: runnerViewModel)

        assertSnapshots(of: SnapshotSupportContainer(runnerView, viewPosition: .centre, width: 100, height: 100),
                        as: [.image])
    }

    func testRunnerViewDoubleNumbersDraw() {
        let runnerViewModel = RunnerView.ViewModel(title: "Draw", odds: "15/10")
        let runnerView = RunnerView()
        runnerView.update(with: runnerViewModel)

        assertSnapshots(of: SnapshotSupportContainer(runnerView, viewPosition: .centre, width: 100, height: 100),
                        as: [.image])
    }

    func testRunnerViewSingleNumberAndDoubleNumberAway() {
        let runnerViewModel = RunnerView.ViewModel(title: "Away", odds: "2/10")
        let runnerView = RunnerView()
        runnerView.update(with: runnerViewModel)

        assertSnapshots(of: SnapshotSupportContainer(runnerView, viewPosition: .centre, width: 100, height: 100),
                        as: [.image])
    }
}
