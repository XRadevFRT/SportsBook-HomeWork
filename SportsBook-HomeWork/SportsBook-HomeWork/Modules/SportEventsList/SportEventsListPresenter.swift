//
//  SportEventsListPresenter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 22.01.24.
//

import Foundation

final class SportEventsListPresenter {

    let sport: Sport
    unowned var view: SportEventsListViewControllerInput
    let interactor: SportEventsListInteractorInput
    let router: SportEventsListRouterInput

    init(sport: Sport, 
         view: SportEventsListViewControllerInput,
         interactor: SportEventsListInteractorInput,
         router: SportEventsListRouterInput) {
        self.sport = sport
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    private func callGetEventsData() {
        view.startActivityIndicator()
        interactor.getEventsData(for: sport.id)
    }

    private func constructSportEventDayViewModels(eventDays: [EventDay]) -> [SportEventsListViewController.SportEventDayViewModel] {
        let eventDayViewModels: [SportEventsListViewController.SportEventDayViewModel] = eventDays.map { eventDay in
            let eventViewModels: [EventView.ViewModel] = eventDay.events.map { event in
                let marketEventViewModel = MarketEventView.ViewModel(
                    marketTypeText: event.primaryMarket.type.text,
                    homeRunnerName: event.name.parseTeams().home,
                    awayRunnerName: event.name.parseTeams().away)

                let runnerViewModels = constructRunnerViewModels(event.primaryMarket.runners)
                return .init(marketEventViewModel: marketEventViewModel, runnerViewModel: runnerViewModels)
            }
            return .init(dateText: eventDay.dateText, eventViewModel: eventViewModels)
        }

        return eventDayViewModels
    }

    private func constructRunnerViewModels(_ runners: [Runner]) -> [RunnerView.ViewModel] {
        var runnerViewModels: [RunnerView.ViewModel] = []
        for (index, runner) in runners.enumerated() {
            var title: String = "NaN"
            switch runner.marketType {
            case .winDrawWin,
                 .matchBetting:
                if index == runners.startIndex {
                    title = "sportEventsHomeRunner".localized()
                } else if index == runners.endIndex - 1 {
                    title = "sportEventsAwayRunner".localized()
                } else {
                    title = "sportEventsDrawRunner".localized()
                }
            case .totalGoalsInMatch:
                if let totalGoals = runner.totalGoals {
                    title = "\(totalGoals)"
                }
            }
            let runnerViewModel = RunnerView.ViewModel(title: title, odds: runner.odds.text)
            runnerViewModels.append(runnerViewModel)
        }
        return runnerViewModels
    }
}

// MARK: - SportEventsListViewControllerOutput

extension SportEventsListPresenter: SportEventsListViewControllerOutput {
    func viewIsReady() {
        view.updateScreenTitle(sport.name)
        callGetEventsData()
    }
}

// MARK: - SportEventsListInteractorOutput

extension SportEventsListPresenter: SportEventsListInteractorOutput {
    func getSportEventsSuccess(_ result: [EventDay]) {
        view.stopActivityIndicator()
        view.updateUI(eventDays: constructSportEventDayViewModels(eventDays: result))
    }

    func getSportEventsFailed() {
        view.stopActivityIndicator()
        router.showFailedRequestAlert()
    }
}

extension SportEventsListPresenter: SportEventsListRouterOutput {
    func didPressRetry() {
        callGetEventsData()
    }
}
