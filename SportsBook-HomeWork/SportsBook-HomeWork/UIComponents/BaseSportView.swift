//
//  BaseSportView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

class BaseSportView: UIView {

    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        return imageView
    }()

    var onPressed: (() -> Void)?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestureRecognizers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupGestureRecognizers()
    }

    // MARK: - UI Setup
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(chevronImageView)

        NSLayoutConstraint.activate(
            titleLabelConstraints +
            chevronImageViewConstraints
        )
    }

    // MARK: - Gesture Recognizers
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }

    @objc private func viewTapped() {
        onPressed?()
    }

    // MARK: - Public

    func updateTitle(_ text: String) {
        titleLabel.text = text
    }
}

// MARK: - Constraint providers

private extension BaseSportView {
    var titleLabelConstraints: [NSLayoutConstraint] {
        [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
    }

    var chevronImageViewConstraints: [NSLayoutConstraint] {
        [
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chevronImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chevronImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
    }
}
