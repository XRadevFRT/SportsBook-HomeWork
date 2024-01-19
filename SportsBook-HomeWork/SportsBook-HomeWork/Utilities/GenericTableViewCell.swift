//
//  GenericTableViewCell.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

class GenericTableViewCell<View: UIView>: UITableViewCell {

    // Create a property to hold the embedded view
    var embeddedView = View()

    // The container view will hold the embeddedView and the separators. That way we can easily work with custom paddings/
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Separator configuration properties
    var separatorColor: UIColor = .gray {
        didSet {
            topSeparatorView.backgroundColor = separatorColor
            bottomSeparatorView.backgroundColor = separatorColor
        }
    }

    var separatorSize: CGFloat = 1.0 {
        didSet {
            topSeparatorHeightConstraint?.constant = separatorSize
            bottomSeparatorHeightConstraint?.constant = separatorSize
            layoutIfNeeded()
        }
    }

    // Top and bottom separators
    private var topSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var bottomSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Padding configuration properties
    var contentPadding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) {
        didSet {
            updateContainerPadding()
        }
    }

    private var topSeparatorHeightConstraint: NSLayoutConstraint?
    private var bottomSeparatorHeightConstraint: NSLayoutConstraint?
    private var containerViewConstraints: [NSLayoutConstraint] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerViewConstraints = paddingConfiguredContainerViewConstraints

        setupTopSeparatorView()
        setupBottomSeparatorView()
        setupEmbeddedView()

        NSLayoutConstraint.activate(
            containerViewConstraints +
            topSeparatorConstraints +
            bottomSeparatorConstraints +
            embeddedViewConstraints
        )
    }

    private func setupTopSeparatorView() {
        contentView.addSubview(topSeparatorView)
        topSeparatorView.backgroundColor = separatorColor
        topSeparatorView.isHidden = true
        topSeparatorHeightConstraint = topSeparatorView.heightAnchor.constraint(equalToConstant: separatorSize)
    }

    private func setupBottomSeparatorView() {
        contentView.addSubview(bottomSeparatorView)
        bottomSeparatorView.backgroundColor = separatorColor
        bottomSeparatorView.isHidden = false
        bottomSeparatorHeightConstraint = bottomSeparatorView.heightAnchor.constraint(equalToConstant: separatorSize)
    }

    private func setupEmbeddedView() {
        containerView.addSubview(embeddedView)
        embeddedView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func updateContainerPadding() {
        NSLayoutConstraint.deactivate(containerViewConstraints)
        containerViewConstraints.removeAll()

        containerViewConstraints = paddingConfiguredContainerViewConstraints
        NSLayoutConstraint.activate(containerViewConstraints)
    }

    func configureSeparators(isFirst: Bool, isLast: Bool) {
        topSeparatorView.isHidden = isFirst
        bottomSeparatorView.isHidden = isLast
    }
}

private extension GenericTableViewCell {
    var topSeparatorConstraints: [NSLayoutConstraint] {
        [
            topSeparatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topSeparatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparatorHeightConstraint!
        ]
    }

    var bottomSeparatorConstraints: [NSLayoutConstraint] {
        [
            bottomSeparatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparatorHeightConstraint!
        ]
    }

    var embeddedViewConstraints: [NSLayoutConstraint] {
        [
            embeddedView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor),
            embeddedView.bottomAnchor.constraint(equalTo: bottomSeparatorView.topAnchor),
            embeddedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            embeddedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ]
    }

    var paddingConfiguredContainerViewConstraints: [NSLayoutConstraint] {
        [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentPadding.top),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentPadding.left),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentPadding.right),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentPadding.bottom)
        ]
    }
}
