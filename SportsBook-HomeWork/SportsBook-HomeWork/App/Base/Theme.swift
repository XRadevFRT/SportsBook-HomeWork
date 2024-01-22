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
        static let standardCellHSpacing: UIEdgeInsets = .init(top: 18, left: 16, bottom: 18, right: 16)
        static let standardSectionSpacing: UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)
    }

    enum CornerRadiusProvider {
        static let defaultRadius: CGFloat = 12

    }
}


