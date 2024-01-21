//
//  StatusScreenRouter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

protocol StatusScreenRouterInput {
    func showBadAPIStatusAlert()
}

protocol StatusScreenRouterOutput: AnyObject {
    func didPressRetry()
}

final class StatusScreenRouter: AlertPresentable {
    weak var output: StatusScreenRouterOutput?
    var presentingViewController: UIViewController

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}

// MARK: - StatusScreenRouterInput

extension StatusScreenRouter: StatusScreenRouterInput {
    func showBadAPIStatusAlert() {
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
