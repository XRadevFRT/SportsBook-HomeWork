//
//  StatusScreenPresenter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import Foundation

final class StatusScreenPresenter {
    unowned var view: StatusScreenViewControllerInput
    let interactor: StatusScreenInteractorInput
    let router: StatusScreenRouterInput

    private let completionHandler: StatusScreenBuilderCompletionHandler

    init(view: StatusScreenViewControllerInput, 
         interactor: StatusScreenInteractorInput,
         router: StatusScreenRouterInput,
         completionHandler: @escaping StatusScreenBuilderCompletionHandler) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.completionHandler = completionHandler
    }

    private func callGetAPIStatus() {
        view.startActivityIndicator()
        interactor.getAPIStatus()
    }
}

// MARK: - StatusScreenViewControllerOutput

extension StatusScreenPresenter: StatusScreenViewControllerOutput {
    func viewIsReady() {
        callGetAPIStatus()
    }
}

// MARK: - StatusScreenInteractorOutput

extension StatusScreenPresenter: StatusScreenInteractorOutput {
    func getAPIStatusSuccess(_ result: APIStatus) {
        view.stopActivityIndicator()
        guard result.status == "OK" else {
            router.showBadAPIStatusAlert()
            return
        }
        completionHandler()
    }

    func getAPIStatusFailed() {
        view.stopActivityIndicator()
        router.showBadAPIStatusAlert()
    }
}

// MARK: - StatusScreenRouterOutput

extension StatusScreenPresenter: StatusScreenRouterOutput {
    func didPressRetry() {
        callGetAPIStatus()
    }
}
