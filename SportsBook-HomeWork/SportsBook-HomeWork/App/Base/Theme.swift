//
//  Theme.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 21.01.24.
//

import UIKit.UIColor

enum Theme {

    enum Colors {
        static let commonGrey: UIColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    }

    enum Spacings {
        static let standardCellHSpacing: UIEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
    }

    enum CornerRadiusProvider {
        static let defaultRadius: CGFloat = 12

    }
}


