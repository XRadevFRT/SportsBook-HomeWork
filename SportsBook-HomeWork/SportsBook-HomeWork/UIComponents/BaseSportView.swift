//
//  BaseSportView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

final class BaseSportView: TapAnimatedView {

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
        setupOnTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("BaseSportView.init(coder:) has not been implemented")
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

    private func setupOnTap() {
        onTap = { [weak self] in
            self?.onPressed?()
        }
    }

    // MARK: - Public

    func updateTitle(_ text: String) {
        guard !text.isEmpty else {
            titleLabel.text = "sportListScreenEmptySportName".localized()
            return
        }
        titleLabel.text = text
    }
}

// MARK: - Constraint providers

private extension BaseSportView {
    var titleLabelConstraints: [NSLayoutConstraint] {
        [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -5)
        ]
    }

    var chevronImageViewConstraints: [NSLayoutConstraint] {
        [
            chevronImageView.heightAnchor.constraint(equalToConstant: 14),
            chevronImageView.widthAnchor.constraint(equalToConstant: 14),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
}
