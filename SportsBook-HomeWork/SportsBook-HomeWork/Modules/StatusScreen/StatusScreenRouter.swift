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

final class StatusScreenRouter {
    weak var output: StatusScreenRouterOutput?
    private var presentingViewController: UIViewController

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}

// MARK: - StatusScreenRouterInput

extension StatusScreenRouter: StatusScreenRouterInput {
    func showBadAPIStatusAlert() {
        let title = "Oops..."
        let message = "It seems something is wrong with the local API. Please restart the API and try again"
        let retryActionTitle = "Retry"

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(
            title: retryActionTitle,
            style: .default,
            handler: { [weak output] _ in
                output?.didPressRetry()
            })

        alertViewController.addAction(retryAction)

        DispatchQueue.main.async { [weak self] in
            self?.presentingViewController.present(alertViewController, animated: true, completion: nil)
        }
    }
}
