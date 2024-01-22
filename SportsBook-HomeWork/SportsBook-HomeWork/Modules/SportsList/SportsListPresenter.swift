//
//  SportsListPresenter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import Foundation

final class SportsListPresenter {
    unowned var view: SportsListViewControllerInput
    let interactor: SportsListInteractorInput
    let router: SportsListRouterInput

    private let completionHandler: SportsListBuilderCompletionHandler

    init(view: SportsListViewControllerInput, 
         interactor: SportsListInteractorInput,
         router: SportsListRouterInput,
         completionHandler: @escaping SportsListBuilderCompletionHandler) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.completionHandler = completionHandler
    }

    private func callGetSportList() {
        view.startActivityIndicator()
        interactor.getSportsList()
    }
}

// MARK: - SportsListViewControllerOutput

extension SportsListPresenter: SportsListViewControllerOutput {
    func didSelectSport(_ sport: Sport) {
        completionHandler(.sportSelected(sport))
    }
    
    func viewIsReady() {
        callGetSportList()
    }
}

// MARK: - SportsListInteractorOutput

extension SportsListPresenter: SportsListInteractorOutput {
    func getSportsSuccess(_ result: [Sport]) {
        view.stopActivityIndicator()
        view.updateUI(sports: result)
    }
    
    func getSportsFailed() {
        view.stopActivityIndicator()
        router.showFailedRequestAlert()
    }
}

// MARK: - SportsListRouterOutput

extension SportsListPresenter: SportsListRouterOutput {
    func didPressRetry() {
        callGetSportList()
    }
}
