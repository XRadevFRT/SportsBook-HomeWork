//
//  GenericTableViewCell.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

final class GenericTableViewCell<View: UIView>: UITableViewCell {

    // MARK: - Private properties

    // The container view will hold the embeddedView and the separators. That way we can easily work with custom paddings
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var constraintsHolder: [NSLayoutConstraint] = []

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

    // MARK: - Public properties

    var embeddedView = View()

    var insets: UIEdgeInsets = .zero {
        didSet {
            if insets != oldValue {
                setContainerConstraints()
            }
        }
    }

    var separatorHeight: CGFloat = 1.0 {
        didSet {
            setContainerConstraints()

        }
    }

    var separatorColor: UIColor = Theme.Colors.commonGrey {
        didSet {
            topSeparatorView.backgroundColor = separatorColor
            bottomSeparatorView.backgroundColor = separatorColor
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("GenericTableViewCell<ViewL UIView>.init(coder:) has not been implemented")
    }

    // MARK: - Private functions

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(embeddedView)
        embeddedView.translatesAutoresizingMaskIntoConstraints = false

        setupTopSeparatorView()
        setupBottomSeparatorView()
        setupTapGestureForTapAnimatedView()

        setContainerConstraints()
    }

    private func setupTapGestureForTapAnimatedView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }

    @objc private func handleTapGesture() {
        guard let tapAnimatedView = embeddedView as? TapAnimatedView else {
            return
        }
        tapAnimatedView.initiateTapAction()
    }

    private func setupTopSeparatorView() {
        containerView.addSubview(topSeparatorView)
        topSeparatorView.backgroundColor = separatorColor
        topSeparatorView.isHidden = false
    }

    private func setupBottomSeparatorView() {
        containerView.addSubview(bottomSeparatorView)
        bottomSeparatorView.backgroundColor = separatorColor
        bottomSeparatorView.isHidden = false
    }

    private func setContainerConstraints() {
        NSLayoutConstraint.deactivate(constraintsHolder)
        constraintsHolder.removeAll()
        constraintsHolder.append(contentsOf: containerViewConstraints)
        constraintsHolder.append(contentsOf: embeddedViewConstraints)
        constraintsHolder.append(contentsOf: topSeparatorConstraints)
        constraintsHolder.append(contentsOf: bottomSeparatorConstraints)
        NSLayoutConstraint.activate(constraintsHolder)
    }

    // MARK: - Public functions

    func configureSeparators(isFirst: Bool, isLast: Bool) {
        topSeparatorView.isHidden = isFirst
        bottomSeparatorView.isHidden = isLast
    }
}

// MARK: - Constrain providers

private extension GenericTableViewCell {

    var topSeparatorConstraints: [NSLayoutConstraint] {
        [
            topSeparatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topSeparatorView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: separatorHeight)
        ]
    }

    var bottomSeparatorConstraints: [NSLayoutConstraint] {
        [
            bottomSeparatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: separatorHeight)
        ]
    }

    var containerViewConstraints: [NSLayoutConstraint] {
        [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets.left),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets.right),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
    }

    var embeddedViewConstraints: [NSLayoutConstraint] {
        [
            embeddedView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: separatorHeight + insets.top),
            embeddedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            embeddedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            embeddedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -separatorHeight - insets.bottom)
        ]
    }
}
