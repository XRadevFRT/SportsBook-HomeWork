//
//  SportsListRouter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import UIKit

protocol SportsListRouterInput {
    func showFailedRequestAlert()
}

protocol SportsListRouterOutput: AnyObject {
    func didPressRetry()
}

final class SportsListRouter: AlertPresentable {
    weak var output: SportsListRouterOutput?
    var presentingViewController: UIViewController

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}

// MARK: - SportsListRouterInput

extension SportsListRouter: SportsListRouterInput {
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
