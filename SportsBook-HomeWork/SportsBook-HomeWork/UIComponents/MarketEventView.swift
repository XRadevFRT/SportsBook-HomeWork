//
//  MarketEventView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 21.01.24.
//

import UIKit

final class MarketEventView: UIView {

    struct ViewModel {
        let marketTypeText: String
        let homeRunnerName: String
        let awayRunnerName: String
    }

    private let marketTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let homeRunnerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let awayRunnerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 9
        return vStack
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("MarketEventView.init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addSubview(vStack)
        NSLayoutConstraint.activate(vStackConstraints)

        vStack.addArrangedSubview(marketTypeLabel)
        vStack.addArrangedSubview(homeRunnerNameLabel)
        vStack.addArrangedSubview(awayRunnerNameLabel)
    }

    // MARK: - Public

    func update(with viewModel: ViewModel) {
        marketTypeLabel.text = viewModel.marketTypeText
        homeRunnerNameLabel.text = viewModel.homeRunnerName
        awayRunnerNameLabel.text = viewModel.awayRunnerName
    }
}

// MARK: - Constraint providers

private extension MarketEventView {
    var vStackConstraints: [NSLayoutConstraint] {
        [
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }
}
