//
//  OddsView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 21.01.24.
//

import UIKit

final class OddsView: UIView {

    // MARK: - Properties

    private let oddsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }

    required init?(coder: NSCoder) {
        fatalError("OddsView.init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Theme.Colors.commonGrey
        layer.cornerRadius = Theme.CornerRadiusProvider.defaultRadius

        addSubview(oddsLabel)
        NSLayoutConstraint.activate(oddsViewConstraints + oddsLabelConstraints)
    }

    // MARK: - Public

    func updateOddsLabel(_ odds: String) {
        oddsLabel.text = odds
    }
}

// MARK: - Constraint providers

private extension OddsView {
    var oddsViewConstraints: [NSLayoutConstraint] {
        [
            widthAnchor.constraint(equalToConstant: 55),
            heightAnchor.constraint(equalToConstant: 55)
        ]
    }

    var oddsLabelConstraints: [NSLayoutConstraint] {
        [
            oddsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            oddsLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
    }
}
