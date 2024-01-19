//
//  UITableView+dequeuCell.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(ofType type: T.Type) -> T     {
       let cellName = String(describing: T.self)

       return dequeueReusableCell(withIdentifier: cellName) as! T
    }
}
