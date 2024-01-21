//
//  EventDateView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 22.01.24.
//

import UIKit

final class EventDateView: UIView {

    // MARK: - Properties

    private let eventDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }

    required init?(coder: NSCoder) {
        fatalError("EventDateView.init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addSubview(eventDateLabel)
        NSLayoutConstraint.activate(eventDateLabelConstraints)
    }

    // MARK: - Public

    func updateEventDate(_ dateText: String) {
        eventDateLabel.text = dateText
    }
}

// MARK: - Constraint providers

private extension EventDateView {
    var eventDateLabelConstraints: [NSLayoutConstraint] {
        [
            eventDateLabel.topAnchor.constraint(equalTo: topAnchor),
            eventDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            eventDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
}
