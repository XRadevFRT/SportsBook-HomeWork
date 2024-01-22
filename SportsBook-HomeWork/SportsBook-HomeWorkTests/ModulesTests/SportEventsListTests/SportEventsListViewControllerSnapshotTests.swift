//
//  SportEventsListViewControllerSnapshotTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 22.01.24.
//

import XCTest
import SnapshotTesting
@testable import SportsBook_HomeWork

final class SportEventsListViewControllerSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Set TRUE when creating images, FALSE when you test
        // isRecording = true
    }

    func getMockEventViewModel(dateText: String) -> SportEventsListViewController.SportEventDayViewModel {
        let mockRunnerViewModel1: RunnerView.ViewModel = .init(title: "Home", odds: "2/10")
        let mockRunnerViewModel2: RunnerView.ViewModel = .init(title: "Draw", odds: "19/9")
        let mockRunnerViewModel3: RunnerView.ViewModel = .init(title: "Away", odds: "15/32")

        let mockMarketEventViewModel: MarketEventView.ViewModel =
            .init(marketTypeText: "Match Odds",
                  homeRunnerName: "Man Utd",
                  awayRunnerName: "Liverpool")

        let mockEventViewModel: EventView.ViewModel =
            .init(marketEventViewModel: mockMarketEventViewModel,
                  runnerViewModel: [mockRunnerViewModel1,
                                    mockRunnerViewModel2,
                                    mockRunnerViewModel3])

        let mockSportEventDayViewModel: SportEventsListViewController.SportEventDayViewModel =
            .init(dateText: dateText,
                  eventViewModel: [mockEventViewModel])

        return mockSportEventDayViewModel
    }

    func testSportEventsListViewControllerWithOneEvent() {
        let vc = SportEventsListViewController()
        vc.updateScreenTitle("Football")
        vc.updateUI(eventDays: [getMockEventViewModel(dateText: "Thursday 5th July 2022")])

        assertSnapshot(of: UINavigationController(rootViewController: vc), as: .image)
    }

    func testSportEventsListViewControllerWithTwoDates() {
        let vc = SportEventsListViewController()
        vc.updateScreenTitle("Rugby")
        vc.updateUI(eventDays: [getMockEventViewModel(dateText: "Thursday 5th July 2022"),
                                getMockEventViewModel(dateText: "Saturday 1st May 2022")])

        assertSnapshot(of: UINavigationController(rootViewController: vc), as: .image)
    }
}
