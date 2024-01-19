//
//  UITableVIew+registerCell.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)

        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)

            register(nib, forCellReuseIdentifier: cellName)
        } else {
            register(T.self, forCellReuseIdentifier: cellName)
        }
    }
}
