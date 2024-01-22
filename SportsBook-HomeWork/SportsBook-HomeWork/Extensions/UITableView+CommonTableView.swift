//
//  UITableView+CommonTableView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import UIKit

extension UITableView {
    static func commonTableView(style: UITableView.Style = .plain) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        return tableView
    }
}

