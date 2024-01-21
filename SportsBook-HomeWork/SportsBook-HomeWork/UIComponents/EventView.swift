//
//  EventView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 21.01.24.
//

import UIKit

final class EventView: UIView {

    struct ViewModel {
        let marketEventViewModel: MarketEventView.ViewModel
        let runnerViewModel: [RunnerView.ViewModel]
    }

    private let marketEventView: MarketEventView = .init()

    private let hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.spacing = 17
        return hStack
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("EventView.init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addSubview(hStack)
        addSubview(marketEventView)
        NSLayoutConstraint.activate(hStackConstraints + marketEventViewConstraints)
    }

    private func buildUI(_ viewModel: ViewModel) {
        for runnerViewModel in viewModel.runnerViewModel {
            let runnerView = RunnerView()
            runnerView.update(with: runnerViewModel)
            hStack.addArrangedSubview(runnerView)
        }
        marketEventView.update(with: viewModel.marketEventViewModel)
    }

    // MARK: - Public

    func update(with viewModel: ViewModel) {
        buildUI(viewModel)
    }
}

// MARK: - Constraint providers

private extension EventView {
    var hStackConstraints: [NSLayoutConstraint] {
        [
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -10),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }

    var marketEventViewConstraints: [NSLayoutConstraint] {
        [
            marketEventView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            marketEventView.topAnchor.constraint(equalTo: topAnchor),
            marketEventView.bottomAnchor.constraint(equalTo: bottomAnchor),
            marketEventView.trailingAnchor.constraint(equalTo: hStack.leadingAnchor)
        ]
    }
}
