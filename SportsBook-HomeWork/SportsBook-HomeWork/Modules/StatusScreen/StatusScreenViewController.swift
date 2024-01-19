//
//  StatusScreenViewController.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

protocol StatusScreenViewControllerInput: Activable { }

protocol StatusScreenViewControllerOutput: AnyObject {
    func viewIsReady()
}

final class StatusScreenViewController: UIViewController, StatusScreenViewControllerInput {

    enum Constants {
        static let titleText = "SportsBook"
        static let subtitleText = "by Radoslav Radev"
        static let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 50)
        static let subtitleFont = UIFont(name: "HelveticaNeue-Regular", size: 17)
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.titleFont
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.subtitleText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.subtitleFont
        return label
    }()

    var output: StatusScreenViewControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        output?.viewIsReady()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        NSLayoutConstraint.activate(
            titleLabelConstraints +
            subtitleLabelConstraints
        )
    }
}

// MARK: - Constraint providers

private extension StatusScreenViewController {
    var titleLabelConstraints: [NSLayoutConstraint] {
        [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -190)
        ]
    }

    var subtitleLabelConstraints: [NSLayoutConstraint] {
        [
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ]
    }
}
