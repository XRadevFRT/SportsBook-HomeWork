//
//  AlertPresentable.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import UIKit

protocol AlertPresentable: AnyObject {
    var presentingViewController: UIViewController { get }

    func presentAlert(title: String?,
                      message: String?,
                      actions: [UIAlertAction],
                      preferredStyle: UIAlertController.Style,
                      completion: (() -> Void)?)
}

extension AlertPresentable {
    func presentAlert(title: String?,
                      message: String?,
                      actions: [UIAlertAction],
                      preferredStyle: UIAlertController.Style = .alert,
                      completion: (() -> Void)? = nil) {

        DispatchQueue.main.async { [weak self] in
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)

        for action in actions {
            alertController.addAction(action)
        }
            self?.presentingViewController.present(alertController,
                                                   animated: true,
                                                   completion: completion)
        }
    }
}

extension UIAlertAction {
    static func retryAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "alertRetryActionTitle".localized(),
                             style: .default,
                             handler: handler)
    }
}

