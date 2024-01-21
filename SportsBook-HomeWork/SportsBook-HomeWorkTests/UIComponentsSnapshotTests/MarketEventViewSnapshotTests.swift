//
//  MarketEventViewSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class MarketEventViewSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
        //  isRecording = true
    }

    func testMarketEventViewMatchOdds() {
        let marketEventViewModel = MarketEventView.ViewModel(marketTypeText: MarketType.winDrawWin.text,
                                                             homeRunnerName: "Chelsea",
                                                             awayRunnerName: "Leeds")
        let marketEventView = MarketEventView()
        marketEventView.update(with: marketEventViewModel)

        assertSnapshot(of: SnapshotSupportContainer(marketEventView, viewPosition: .centre, width: 100, height: 100),
                       as: .image)
    }

    func testMarketEventViewGoalsInMatch() {
        let marketEventViewModel = MarketEventView.ViewModel(marketTypeText: MarketType.totalGoalsInMatch.text,
                                                             homeRunnerName: "Newcastle Utd",
                                                             awayRunnerName: "Leicester")
        let marketEventView = MarketEventView()
        marketEventView.update(with: marketEventViewModel)

        assertSnapshot(of: SnapshotSupportContainer(marketEventView, viewPosition: .centre, width: 150, height: 150),
                       as: .image)
    }

    func testMarketEventViewMatchBetting() {
        let marketEventViewModel = MarketEventView.ViewModel(marketTypeText: MarketType.matchBetting.text,
                                                             homeRunnerName: "Castleford Tigers",
                                                             awayRunnerName: "Catalans Dragons")
        let marketEventView = MarketEventView()
        marketEventView.update(with: marketEventViewModel)

        assertSnapshot(of: SnapshotSupportContainer(marketEventView, viewPosition: .centre, width: 150, height: 150),
                       as: .image)
    }
}
