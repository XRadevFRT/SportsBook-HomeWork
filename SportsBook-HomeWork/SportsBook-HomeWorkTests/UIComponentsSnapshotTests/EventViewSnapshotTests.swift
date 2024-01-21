//
//  EventViewSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 21.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class EventViewSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
        // isRecording = true
    }

    func testEventViewMatchOddsShortNames() {
        let marketEventViewModel = MarketEventView.ViewModel(marketTypeText: MarketType.winDrawWin.text,
                                                             homeRunnerName: "Chelsea",
                                                             awayRunnerName: "Leeds")
        let runnerViewModelHome = RunnerView.ViewModel(title: "Home", odds: "5/3")
        let runnerViewModelDraw = RunnerView.ViewModel(title: "Draw", odds: "15/10")
        let runnerViewModelAway = RunnerView.ViewModel(title: "Away", odds: "2/10")

        let eventViewModel = EventView.ViewModel(
            marketEventViewModel: marketEventViewModel,
            runnerViewModel: [
                runnerViewModelHome,
                runnerViewModelDraw,
                runnerViewModelAway
            ])

        let eventView = EventView()
        eventView.update(with: eventViewModel)

        assertSnapshot(of: SnapshotSupportContainer(eventView), as: .image)
    }

    func testEventViewGoalsInMatchShortNames() {
        let marketEventViewModel = MarketEventView.ViewModel(marketTypeText: MarketType.totalGoalsInMatch.text,
                                                             homeRunnerName: "Liverpool",
                                                             awayRunnerName: "Man Utd")
        let runnerViewModelHome = RunnerView.ViewModel(title: "2", odds: "5/3")
        let runnerViewModelDraw = RunnerView.ViewModel(title: "4", odds: "15/10")

        let eventViewModel = EventView.ViewModel(
            marketEventViewModel: marketEventViewModel,
            runnerViewModel: [
                runnerViewModelHome,
                runnerViewModelDraw
            ])

        let eventView = EventView()
        eventView.update(with: eventViewModel)

        assertSnapshot(of: SnapshotSupportContainer(eventView), as: .image)
    }
    
    func testEventViewMatchBettingLongerNames() {
        let marketEventViewModel = MarketEventView.ViewModel(marketTypeText: MarketType.matchBetting.text,
                                                             homeRunnerName: "Castleford Tigers Utd",
                                                             awayRunnerName: "Catalans Dragons")
        let runnerViewModelHome = RunnerView.ViewModel(title: "Home", odds: "5/3")
        let runnerViewModelDraw = RunnerView.ViewModel(title: "Draw", odds: "15/10")
        let runnerViewModelAway = RunnerView.ViewModel(title: "Away", odds: "10/5")

        let eventViewModel = EventView.ViewModel(
            marketEventViewModel: marketEventViewModel,
            runnerViewModel: [
                runnerViewModelHome,
                runnerViewModelDraw,
                runnerViewModelAway
            ])

        let eventView = EventView()
        eventView.update(with: eventViewModel)

        assertSnapshot(of: SnapshotSupportContainer(eventView), as: .image)
    }
}
