//
//  RunnerView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 21.01.24.
//

import UIKit

final class RunnerView: UIView {

    struct ViewModel {
        let title: String
        let odds: String
    }

    private let oddsView: OddsView = .init()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("RunnerView.init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addSubview(oddsView)
        addSubview(titleLabel)
        NSLayoutConstraint.activate(oddsViewConstraints + titleLabelConstraints)
    }

    // MARK: - Public

    func update(with viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        oddsView.updateOddsLabel(viewModel.odds)
    }
}

// MARK: - Constraint providers

private extension RunnerView {
    var titleLabelConstraints: [NSLayoutConstraint] {
        [
            titleLabel.bottomAnchor.constraint(equalTo: oddsView.topAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }

    var oddsViewConstraints: [NSLayoutConstraint] {
        [
            oddsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            oddsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            oddsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }
}
