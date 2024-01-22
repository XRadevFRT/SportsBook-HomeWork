//
//  SportEventsListPresenterTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 22.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class SportEventsListPresenterTests: XCTestCase {
    private var mockView: MockSportEventsListViewController!
    private var mockInteractor: MockSportEventsListInteractor!
    private var mockRouter: MockSportEventsListRouter!

    override func setUp() {
        super.setUp()
        mockView = .init()
        mockInteractor = .init()
        mockRouter = .init()
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    private func getPresenter(with sport: Sport = .init(id: 1, name: "")) -> SportEventsListPresenter {
        return .init(sport: sport,
                     view: mockView,
                     interactor: mockInteractor,
                     router: mockRouter)
    }

    func testViewIsReady() {
        let expectedSportName = "Football"
        let presenter = getPresenter(with: .init(id: 102, name: "Football"))

        mockView.updateScreenTitleHandler = { title in
            XCTAssertEqual(title, expectedSportName)
        }

        presenter.viewIsReady()

        XCTAssertEqual(mockView.updateScreenTitleCallCount, 1)
        XCTAssertEqual(mockInteractor.getEventsDataCallCount, 1)
    }

    func testGetSportEventsFailed() {
        getPresenter().getSportEventsFailed()

        XCTAssertEqual(mockView.stopActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockRouter.showFailedRequestAlertCallCount, 1)
    }

    func testDidPressRetry() {
        getPresenter().didPressRetry()

        XCTAssertEqual(mockView.startActivityIndicatorCallCount, 1)
        XCTAssertEqual(mockInteractor.getEventsDataCallCount, 1)
    }

    func testGetSportEventsSuccess() {
        let odds = Odds(numerator: 2, denominator: 3)
        let homeRunner = Runner(id: "101", name: "", totalGoals: nil, marketType: .winDrawWin, odds: odds)
        let drawRunner = Runner(id: "202", name: "name", totalGoals: nil, marketType: .winDrawWin, odds: odds)
        let awayRunner = Runner(id: "303", name: "name", totalGoals: nil, marketType: .winDrawWin, odds: odds)
        let totalGoalsRunner = Runner(id: "404", name: "name", totalGoals: 5, marketType: .totalGoalsInMatch, odds: odds)
        let primaryMarket = PrimaryMarket(
            id: "101",
            name: "name",
            type: .winDrawWin,
            runners: [homeRunner, drawRunner, totalGoalsRunner, awayRunner])
        let event = Event(id: "404", date: mockedDate, name: "Team1 vs Team2", primaryMarket: primaryMarket)
        let eventDay = EventDay(dateText: "Thursday 5th July", events: [event])

        let presenter = getPresenter()

        mockView.updateUIHandler = { viewModel in
            let first = viewModel.first
            XCTAssertEqual(first?.dateText, "Thursday 5th July")
            XCTAssertEqual(first?.eventViewModel.first?.runnerViewModel.first?.odds, "2/3")
            XCTAssertEqual(first?.eventViewModel.first?.runnerViewModel[1].odds, "2/3")
            XCTAssertEqual(first?.eventViewModel.first?.runnerViewModel[2].odds, "2/3")
            XCTAssertEqual(first?.eventViewModel.first?.runnerViewModel.first?.title, "sportEventsHomeRunner".localized())
            XCTAssertEqual(first?.eventViewModel.first?.runnerViewModel[1].title,  "sportEventsDrawRunner".localized())
            XCTAssertEqual(first?.eventViewModel.first?.runnerViewModel[2].title, "5")
            XCTAssertEqual(first?.eventViewModel.first?.runnerViewModel[3].title, "sportEventsAwayRunner".localized())
            XCTAssertEqual(first?.eventViewModel.first?.marketEventViewModel.homeRunnerName, "Team1")
            XCTAssertEqual(first?.eventViewModel.first?.marketEventViewModel.awayRunnerName, "Team2")
        }

        presenter.getSportEventsSuccess([eventDay])

        XCTAssertEqual(mockView.updateUICallCount, 1)
        XCTAssertEqual(mockView.stopActivityIndicatorCallCount, 1)
    }
}

private extension SportEventsListPresenterTests {
    final class MockSportEventsListViewController: SportEventsListViewControllerInput {
        var updateUICallCount = 0
        var updateUIHandler: (([SportEventsListViewController.SportEventDayViewModel]) -> Void)?
        func updateUI(eventDays: [SportEventsListViewController.SportEventDayViewModel]) {
            updateUICallCount += 1
            if let updateUIHandler = updateUIHandler {
                updateUIHandler(eventDays)
            }
        }
        
        var updateScreenTitleCallCount = 0
        var updateScreenTitleHandler: ((String) -> Void)?
        func updateScreenTitle(_ screenTitle: String) {
            updateScreenTitleCallCount += 1
            if let updateScreenTitleHandler = updateScreenTitleHandler {
                updateScreenTitleHandler(screenTitle)
            }
        }
        
        var startActivityIndicatorCallCount = 0
        func startActivityIndicator() {
            startActivityIndicatorCallCount += 1
        }

        var stopActivityIndicatorCallCount = 0
        func stopActivityIndicator() {
            stopActivityIndicatorCallCount += 1
        }
    }

    final class MockSportEventsListInteractor: SportEventsListInteractorInput {
        var getEventsDataCallCount = 0
        var getEventsDataHandler: ((Int) -> Void)?
        func getEventsData(for sportId: Int) {
            getEventsDataCallCount += 1
            if let getEventsDataHandler = getEventsDataHandler {
                getEventsDataHandler(sportId)
            }
        }
    }

    final class MockSportEventsListRouter: SportEventsListRouterInput {
        var showFailedRequestAlertCallCount = 0
        func showFailedRequestAlert() {
            showFailedRequestAlertCallCount += 1
        }
    }

    var mockedDate: Date {
        var dateComponents = DateComponents()
        dateComponents.year = 1990
        dateComponents.month = 7
        dateComponents.day = 5
        let calendar = Calendar(identifier: .gregorian)

        guard let date = calendar.date(from: dateComponents) else {
            return Date()
        }
        return date
    }
}
