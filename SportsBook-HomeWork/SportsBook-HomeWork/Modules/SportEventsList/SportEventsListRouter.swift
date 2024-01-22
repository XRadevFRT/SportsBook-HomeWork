//
//  SportEventsListRouter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 22.01.24.
//

import UIKit

protocol SportEventsListRouterInput {
    func showFailedRequestAlert()
}

protocol SportEventsListRouterOutput: AnyObject {
    func didPressRetry()
}

final class SportEventsListRouter: AlertPresentable {
    weak var output: SportEventsListRouterOutput?
    var presentingViewController: UIViewController

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}

// MARK: - SportsListRouterInput

extension SportEventsListRouter: SportEventsListRouterInput {
    func showFailedRequestAlert() {
        let retryAction = UIAlertAction.retryAction { [weak self] _ in
            self?.handleRetryAction()
        }

        presentAlert(title: "alertOopsTite".localized(),
                     message: "alertFailedAPICallMessage".localized(),
                     actions: [retryAction])
    }

    func handleRetryAction() {
        output?.didPressRetry()
    }
}
