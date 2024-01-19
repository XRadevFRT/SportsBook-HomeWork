//
//  SnapshotSupportContainer.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

public final class SnapshotSupportContainer<View: UIView>: UIView {
    let view: View

    /// Initializes container view for simple view testing
    ///
    /// - Parameters:
    ///   - view: Generic view that will be snapshotted
    ///   - width: Width of the view - if `nil` is passed the view will be auto sized
    ///   - backgroundColor: the background of the container. When `nil` is passed it will be transparent. Defaults is `.white`.
    public init(_ view: View,
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
        var constraints: [NSLayoutConstraint] = [
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]

        if let width = width {
            constraints.append(view.widthAnchor.constraint(equalToConstant: width))
        }

        if let height = height {
            constraints.append(view.heightAnchor.constraint(equalToConstant: height))
        }

        NSLayoutConstraint.activate(constraints)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
