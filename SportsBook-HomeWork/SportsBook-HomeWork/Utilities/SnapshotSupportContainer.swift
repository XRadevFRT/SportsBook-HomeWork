//
//  SnapshotSupportContainer.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

final class SnapshotSupportContainer<View: UIView>: UIView {
    enum ViewPosition {
        case centre
        case fillSideToSide
    }

    let view: View

    /// Initializes container view for simple view testing
    ///
    /// - Parameters:
    ///   - view: Generic view that will be snapshotted
    ///   - width: Width of the view - if `nil` is passed the view will be auto sized
    ///   - backgroundColor: the background of the container. When `nil` is passed it will be transparent. Defaults is `.white`.
    init(_ view: View,
         viewPosition: ViewPosition = .fillSideToSide,
         width: CGFloat? = 393, // we use iPhone 15 Pro width
         height: CGFloat? = nil,
         backgroundColor: UIColor? = .white) {
        self.view = view

        super.init(frame: .zero)

        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(view)
        var constraints: [NSLayoutConstraint]

        switch viewPosition {
        case .centre:
            constraints = centrePositionConstraints
        case .fillSideToSide:
            constraints = sideToSidePositionConstraints
        }

        if let width = width {
            constraints.append(widthAnchor.constraint(equalToConstant: width))
        }

        if let height = height {
            constraints.append(heightAnchor.constraint(equalToConstant: height))
        }

        NSLayoutConstraint.activate(constraints)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Constraint providers

private extension SnapshotSupportContainer {
    var centrePositionConstraints: [NSLayoutConstraint] {
        [
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
    }

    var sideToSidePositionConstraints: [NSLayoutConstraint] {
        [
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
}
